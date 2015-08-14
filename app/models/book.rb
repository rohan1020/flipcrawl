require 'bookscrawl'
require 'bookcrawljob'

class Book
  include Mongoid::Document
  store_in collection: 'books'
  field :title, type: String
  field :url, type: String
  field :pid, type: String
  field :sid, type: String
  field :info, type: Hash
  field :downloaded, type: Mongoid::Boolean, default: false


  validates :pid, uniqueness: true

  def self.getPid(theUrl)
    params = CGI::parse( URI::parse(theUrl).query )
    params['pid'][0]
  end

  def self.startWork(cat)

    startNum = 1
    endnum = cat.numproducts
    endnum = 1500 if endnum > 1500
    sid = cat.sid

    while startNum < endnum
      
      puts cat.title + " " + startNum.to_s
      begin
        step = Book.getAndSaveBooks sid, startNum
      rescue
        step = 1
      end

      if step == 0
        return startNum
      end
      
      startNum += step

    end

    cat.update(:downloaded => true)
    puts endnum

  end

  def self.getAndSaveBooks(sid, startNum = 20)
    
    bc = BooksCrawl.new(sid)

    pList = bc.getProductList startNum

    # saveListToDb(pList)
    
    Resque.enqueue(BookSaveDbJob,pList)

    return pList.count
    
  end

  def self.saveListToDb(pList)

    pList.map{ |p|
        
      b = Book.new
      
      b.title = p['title']
      b.url = p['url']
      b.sid = p['sid']
      b.pid = Book.getPid(b.url)
      # b.info = p
      
      b.save

    }

    pList.count


  end

  def self.getUnDownloaded
  
    out = Book.all.select{ |b|
      not b.already_saved
    }

    return out

  end

  def self.already_saved(pidd)

    return $redis.sismember("books", pidd)
  end
  def already_saved

    return $redis.sismember("books", pid)
  end

  def self.mark_saved(pidd)

    $redis.sadd("books", pidd)

    # update(:downloaded => true)
  end

  def mark_saved

    $redis.sadd("books", pid)

    # update(:downloaded => true)
  end

  def self.queueBooks

    books = Book.all

    books.each{|b|

      if not b.already_saved

        jobb = {}
        jobb['pid'] = b.pid
        jobb['url'] = b.url

        Resque.enqueue BookInfoCrawlJob, jobb

      end

    }
  end


end


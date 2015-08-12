require 'BooksCrawl'

class Book
  include Mongoid::Document
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

  def self.getAndSaveBooks(sid)
    
    bc = BooksCrawl.new(sid)

    pList = bc.getProductList
    
    pList.map{ |p|
        
      b = Book.new
      
      b.title = p['title']
      b.url = p['url']
      b.sid = p['sid']
      b.pid = Book.getPid(b.url)
      b.info = p
      
      b.save

      puts b.title
    
    }

  end



end

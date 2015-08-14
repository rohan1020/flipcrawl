class BookCrawlJob

  @queue = :bookcrawl

  def self.perform(sid)
    cat = Category.where({'sid' => sid}).first
    
    if cat.downloaded == true
      return 0
    end

    puts "********************************************"
    Book.startWork cat

  end

end

class BookSaveDbJob

  @queue = :booksavedb


  def self.perform(pList)
    
    # puts "Saving to DB"

    t1 = Time.now
    
    Book.saveListToDb(pList)
    
    tdelta = Time.now - t1

    puts "Took #{tdelta.to_s} seconds.."

  end

end


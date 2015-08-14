class BookInfoCrawlJob

  @queue = :bookinfocrawl

  def self.perform(pid)
    
    book = Book.where({'pid' => pid}).first
    
    if book.downloaded == true
      return 0
    end

    puts "Downloading #{book.title}****"

    Bookinfo.getAndSaveBookInfo book

  end

end


class BookInfoSaveDbJob

  @queue = :bookinfosavedb


  def self.perform(bookdata)
    
    # puts "Saving to DB"

    t1 = Time.now
    
    Bookinfo.saveBookDataToDb(bookdata)
    
    tdelta = Time.now - t1

    puts "Took #{tdelta.to_s} seconds.."

  end

end

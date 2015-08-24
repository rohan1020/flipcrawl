class BookInfoCrawlJob

  @queue = :bookinfocrawl

  def self.perform(book)
    
    pid = book['pid']
    url = book['url']
    
    if Book.already_saved pid
      puts "@@@@@ Already downloaded.. SKIPPING"
      return 0
    end

    # puts "Downloading #{book.title}****"
    # puts pid

    t1 = Time.now
    
    Bookinfo.getAndSaveBookInfo url
    
    tdelta = Time.now - t1

    puts "Took #{tdelta.to_s} seconds.."
  end

end


class BookInfoSaveDbJob

  @queue = :bookinfosavedb


  def self.perform(bookdata)
    
    # puts "Saving to DB"

    t1 = Time.now
    
    
    begin
      pid = bookdata['pid']
      # book = Book.where({'pid' => pid}).first
    rescue
      puts "FAILED TO FIND THE BOOK ********************"
    end
    
    if Book.already_saved pid
      puts "@@@@@@ Already SAVED SKipping"
      return 0
    end

    # puts pid
    Bookinfo.saveBookDataToDb(bookdata)
    Book.mark_saved pid

    tdelta = Time.now - t1

    puts "Took #{tdelta.to_s} seconds.."

  end

end

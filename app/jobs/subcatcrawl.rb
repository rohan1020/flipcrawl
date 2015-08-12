class SubCatCrawl

  @queue = :subcat

  def self.perform(c)
    url = "http://flipkart.com" + c['url']

    puts url

    cat  = Category.where({'sid' => c['sid']}).first
    if cat.parsed == true
      puts "Already Parsed!"
      return
    end

    Category.getAndSaveCats(url)
    cat.update(:parsed => true)

  end

end


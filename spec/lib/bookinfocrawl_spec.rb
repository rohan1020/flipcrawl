require_relative "../../lib/bookinfocrawl"

describe BookInfoCrawl do
  
  it "gets book information from url" do

    url = '/win-friends-influence-people-english/p/itmdze5any9rqg5q?pid=9789380494340&icmpid=reco_pp_personalhistoryFooter_book_na_3'
    bc = BookInfoCrawl.new url
    require "awesome_print"

    ap bc.getBookInfo


  end


end

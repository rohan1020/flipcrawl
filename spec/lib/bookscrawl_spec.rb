require_relative "../../lib/bookscrawl"

describe BooksCrawl do
  
  it "gets list of books given starting number" do

    sid = "bks"
    bc = BooksCrawl.new(sid)
    
    prodList = bc.getProductList
    puts prodList
    
    expect(prodList.count).to be > 0

  end

end

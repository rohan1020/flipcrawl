require_relative "../../lib/SubCatFinder"

describe SubCatFinder do
  
  it "fetches html page with list of categories" do
    
    url = "http://flipkart.com//books/philosophy/pr?sid=bks,1zh"
    
    scat = SubCatFinder.new(url)
    catList = scat.getCatList
    
    puts catList
    expect(catList.count).to be > 0 

  end

end



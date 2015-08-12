require 'htmlFetch'

class SubCatFinder

  def initialize(url)
    
    @url = url

  end

  def getCatList

    doc = HtmlFetch.fetch_doc(@url)

    substores = doc.css "#substores"

    allLi = substores.css "li[class='store']"
    
    catDetails = allLi.map{ |x| 
      out = {}

      out['href'] = x.css("a")[0]['href'] 
      out['sid'] = x.css("a")[0]['sid'] 
      numText = x.css("span")[0].text.strip
      out['num'] = numText.gsub(",","").gsub("(", "").gsub(")", "").to_i
      x.css("span").remove
      out['title'] = x.css("a")[0].text.strip
      
      out
    }

    catDetails

  end

  def saveCategories
    
    catList = getCatList
    
    catList.map{ |c|
      
      newCat = Category.new

      newCat.sid = c['sid']
      newCat.title = c['title']
      newCat.url = c['href']
      newCat.numproducts = c['num']
      newCat.info = c

      puts newCat

    }


  end
  

end

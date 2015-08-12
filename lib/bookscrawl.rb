require 'htmlFetch'

class BooksCrawl

  @@baseUrl = "http://www.flipkart.com/lc/pr/pv1/spotList1/spot1/productList"

  def initialize(sid)
    @sid = sid
  end

  def generateUrl(startNum)
    url = @@baseUrl + "?sid=#{@sid}" +  "&start=#{startNum}" 
    url
  end

  def getAllProductList

  end

  def getProductList(startNum = 1)
    
    prodList = []

    begin

      doc = HtmlFetch.fetch_doc(generateUrl(startNum))
    
    rescue
      return []
    end

    prods = doc.css("a.lu-title")

    prodList = prods.map{ |x|
      
      out = {}
      
      out['title'] = x.text.strip
      out['url'] = x['href']
      out['sid'] = @sid
      
      out
    }

    prodList
  end

  

end

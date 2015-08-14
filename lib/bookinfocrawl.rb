require 'htmlFetch'

class BookInfoCrawl

  def initialize(url)
    @url = url
  end

  def getBookInfo
    out = {}

    doc = HtmlFetch.fetch_doc("http://flipkart.com"+@url)

    out['title'] = doc.css("h1.title").text.strip
    out['price'] = doc.css("span.selling-price").text.strip
    out['categories'] =  doc.css(".clp-breadcrumb").text.strip.gsub(/\s+/, " ")
    out['html'] = ''#doc.to_s

    out['author'] = doc.css(".bookDetails a").text

    meta = {}
    
    ap doc.css(".specTable tr").each{|row|
      
      if row.css("td").count == 2
          
        key = row.css("td")[0].text.strip
        val = row.css("td")[1].text.strip
        meta[key] = val

      end
    }

    out['metadata'] = meta
    out['url'] = @url
    out['pid'] = CGI::parse( URI::parse(@url).query)['pid'][0]

    out['mainimg'] = doc.css(".mainImage img")[0]['data-src']
    
    allImgs = []
    
    doc.css(".carouselContainer ul li").each{|im|
      
      allImgs.push im.css(".thumb")[0]['style'].scan(/\(([^\)]+)\)/).first.first
    
    }
    out['imgs'] = allImgs
    out

  end

end

class SubCatFinder

  def self.fetch_doc(url)
    require 'nokogiri'
    require 'open-uri'
    
    require 'digest'

    fname = Digest::SHA256.hexdigest url

    fpath = "tmp/" + fname
    
    if File.exist?(fpath)
      doc = Nokogiri::HTML open(fpath).read
    else
      doc = Nokogiri::HTML(open(url).read)
      f = open(fpath, 'w')
      f.write(doc)
      f.close
    end
    
    doc

  end
  
  def initialize(url)
    
    @url = url

  end

  def getCatList

    doc = SubCatFinder.fetch_doc(@url)

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
  

end

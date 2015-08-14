class HtmlFetch

  def self.for_url(url)
    
    require 'open-uri'
    source = open(url){|f|f.read}

    source
  end

  def self.fetch_doc(url)
    require 'nokogiri'
    require 'open-uri'
    
    require 'digest'

    fname = Digest::SHA256.hexdigest url

    fpath = "/Volumes/BackSSD/Users/flipcrawl/" + fname
    
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

end

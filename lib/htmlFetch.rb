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

    doc = Nokogiri::HTML(open(url.gsub("com//","com/")).read)

    # fname = Digest::SHA256.hexdigest url
    #
    # fpath = "/Volumes/BackSSD/Users/flipcrawl/" + fname
    #
    # if File.exist?(fpath)
    #   doc = Nokogiri::HTML open(fpath).read
    # else
    #   doc = Nokogiri::HTML(open(url).read)
    #   begin
    #     f = open(fpath, 'w')
    #     f.write(doc)
    #     f.close
    #   rescue
    #
    #   
    #   end
    #
    # end
    
    doc

  end

end

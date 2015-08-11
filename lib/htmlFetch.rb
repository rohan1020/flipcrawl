class HtmlFetch

  def self.for_url(url)
    
    require 'open-uri'
    source = open(url){|f|f.read}

    source
  end

end

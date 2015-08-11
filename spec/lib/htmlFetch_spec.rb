require_relative "../../lib/htmlFetch"
# require "vcr"
# require "vcr_helper"


describe HtmlFetch do

  it "fetches an html page from the web" do
    
    # VCR.use_cassette("webfetch") do

      url = "http://algomuse.com"

      htmlOut = HtmlFetch.for_url(url)
      
      expect(htmlOut).to include("<html")
    
    # end
      
  end

end

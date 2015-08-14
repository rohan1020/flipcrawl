require 'rails_helper'

describe Bookinfo do

  it "gets bookinfo" do

    book = Book.new
    book.url = '/golden-path-civil-services-english/p/itmeyxa3rmawwb6f?pid=9788126450602&icmpid=reco_pp_personalhistoryFooter_book_na_1'
    
    Bookinfo.getAndSaveBookInfo book

  end

end

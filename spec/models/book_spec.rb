require 'rails_helper'

describe Book do

  it "gets pid From url" do
    
    urr = "/life-mahatma-gandhi-english/p/itmea6fcagmrndfz?pid=9780007253906&ref=L%253A2457649112799920305&srno=b_1"
    
    pid = Book.getPid urr

    assert pid == "9780007253906"


  end
  
  it "gets and saves books from sid" do
    #
    # sid = "bks"
    #
    # Book.getAndSaveBooks sid

    assert true

  end
  
  it "enqueues work given a criterea and sid" do
    
    sid = 'bks'
    cat = Category.where({'sid' => sid}).first

    Book.startWork cat

  end



end


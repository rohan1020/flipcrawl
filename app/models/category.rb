require 'SubCatFinder'
require 'subcatcrawl'

class Category
  include Mongoid::Document
  field :title, type: String
  field :sid, type: String
  field :numproducts, type: Integer
  field :url, type: String
  field :parsed, type: Mongoid::Boolean, default: false
  field :downloaded, type: Mongoid::Boolean, default: false

  field :info, type: Hash
  
  validates :sid, uniqueness: true


  def self.getAndSaveCats(url)

    sCat = SubCatFinder.new(url)

    catList = sCat.getCatList

    catList.map{ |c|
      
      newCat = Category.new

      newCat.sid = c['sid']
      newCat.title = c['title']
      newCat.url = c['href']
      newCat.numproducts = c['num']
      newCat.info = c

      puts newCat.title

      newCat.save

      Resque.enqueue(SubCatCrawl, newCat)


    }

  end


  def self.startCrawling

    

  end



end

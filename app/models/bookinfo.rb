require 'BookInfoCrawl'
require 'bookinfocrawljob'


class Bookinfo
  include Mongoid::Document
  field :title, type: String
  field :pid, type: String
  field :price, type: String
  field :categories, type: String
  field :author, type: String
  field :metadata, type: Hash
  field :url, type: String
  field :mainimg, type: String
  field :imgs, type: Array
  field :html, type:String

  validates :pid, uniqueness: true


  def self.getAndSaveBookInfo(book)

    bc = BookInfoCrawl.new book.url

    bookData = bc.getBookInfo

    Resque.enqueue(BookInfoSaveDbJob, bookData)

  end

  def self.saveBookDataToDb(bookData)
    
    Bookinfo.create(bookData)

  end

end

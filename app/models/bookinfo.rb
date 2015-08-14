require 'bookinfocrawl'
require 'bookinfocrawljob'
require 'csv'

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

  # validates :pid, uniqueness: true


  def self.to_csv(options = {})
    column_names = Bookinfo.first.attributes.keys
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.search(q)

    results = Bookinfo.where(:title => /#{q}/i)
    results += Bookinfo.where('metadata.ISBN-10' => /#{q}/i)
    results += Bookinfo.where('metadata.ISBN-13' => /#{q}/i)
    results += Bookinfo.where('author' => /#{q}/i)

    results

  end

  def self.getAndSaveBookInfo(book)

    bc = BookInfoCrawl.new book.url

    bookData = bc.getBookInfo

    Resque.enqueue(BookInfoSaveDbJob, bookData)

  end

  def self.saveBookDataToDb(bookData)
    
    Bookinfo.create(bookData)

  end

end

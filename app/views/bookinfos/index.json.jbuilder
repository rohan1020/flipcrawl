json.array!(@bookinfos) do |bookinfo|
  json.extract! bookinfo, :id, :title, :pid, :price, :categories, :author, :metadata, :url, :mainimg, :imgs
  json.url bookinfo_url(bookinfo, format: :json)
end

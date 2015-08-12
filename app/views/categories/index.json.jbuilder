json.array!(@categories) do |category|
  json.extract! category, :id, :title, :sid, :numproducts, :url, :parsed, :downloaded, :info
  json.url category_url(category, format: :json)
end

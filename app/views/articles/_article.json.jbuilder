json.extract! article, :id, :title, :description, :created_at, :updated_at, :archived
json.url article_url(article, format: :json)

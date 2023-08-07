json.extract! document, :id, :title, :kind, :file, :created_at, :updated_at
json.url document_url(document, format: :json)
json.file url_for(document.file)

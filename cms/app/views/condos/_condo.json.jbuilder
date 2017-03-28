json.extract! condo, :id, :name, :address, :client_id, :created_at, :updated_at
json.url condo_url(condo, format: :json)

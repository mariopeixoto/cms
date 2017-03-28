json.extract! client, :id, :name, :contact_name, :contact_phone, :address, :default_fine, :default_interest, :created_at, :updated_at
json.url client_url(client, format: :json)

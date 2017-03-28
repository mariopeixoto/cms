json.extract! tenant, :id, :name, :billing_address, :ssn, :phone_number, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)

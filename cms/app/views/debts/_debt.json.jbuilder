json.extract! debt, :id, :description, :original_amount, :due_date, :debt_type, :unit_id, :tenant_id, :created_at, :updated_at
json.url debt_url(debt, format: :json)

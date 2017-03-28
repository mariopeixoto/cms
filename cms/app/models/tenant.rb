class Tenant < ActiveRecord::Base

  validates :name, :billing_address, :ssn, :phone_number, presence: true
end

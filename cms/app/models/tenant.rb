class Tenant < ActiveRecord::Base

  validates :name, :billing_address, :ssn, :phone_number, :email, presence: true
end

class Debt < ActiveRecord::Base

  enum debt_types: [:condo_fee, :extra_fee, :rent]

  belongs_to :unit
  belongs_to :tenant
  belongs_to :notice

  validates :original_amount, :due_date, :debt_type, :unit, :tenant, presence: true
end

class Debt < ActiveRecord::Base

  enum debt_types: [:condo_fee, :extra_fee, :rent]

  belongs_to :unit
  belongs_to :tenant

  validates :original_amount, :due_date, :debt_type, :unit, :tenant, presence: true

  def updated_amount
    client = self.unit.condo.client
    total_interest = self.original_amount * ((self.days_in_debt * (client.default_interest/30))/100)

    (self.original_amount * (1 + client.default_fine/100)) + total_interest
  end

  def days_in_debt
    (Date.today - self.due_date).to_i
  end
end

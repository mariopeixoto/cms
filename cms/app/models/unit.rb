class Unit < ActiveRecord::Base
  belongs_to :condo
  belongs_to :tenant

  validates :number, :building_name, :condo, presence: true
end

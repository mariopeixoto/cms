FactoryGirl.define do
  factory :unit do
    number { Faker::Number.number(4) }
    building_name { Faker::Number.number(2) }
    association :condo, factory: :condo
    association :tenant, factory: :tenant
  end
end

FactoryGirl.define do
  factory :debt do
    description { Faker::Name.name }
    original_amount { Faker::Number.number(4) }
    due_date { Faker::Date.backward(14) }
    debt_type :rent


    association :tenant, factory: :tenant
    association :unit, factory: :unit
  end
end

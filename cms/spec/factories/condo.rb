FactoryGirl.define do
  factory :condo do
    name { Faker::Name.name }
    association :client, factory: :client
  end
end

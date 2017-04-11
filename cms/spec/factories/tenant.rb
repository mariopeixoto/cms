FactoryGirl.define do
  factory :tenant do
    name { Faker::Name.name }
    billing_address { Faker::Address.street_address }
    ssn { Faker::Number.number(11) }
    phone_number { Faker::PhoneNumber }
  end
end

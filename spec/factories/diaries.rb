FactoryBot.define do
  factory :diary do
    body { Faker::Lorem.characters(number: 200) }
    exercise { Faker::Lorem.characters(number: 10) }
    sleep { Faker::Lorem.characters(number: 10) }
    cigarette { Faker::Lorem.characters(number: 10) }
    drinking { Faker::Lorem.characters(number: 10) }
  end
end
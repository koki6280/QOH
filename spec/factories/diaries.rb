FactoryBot.define do
  factory :diary do
    body { Faker::Lorem.characters(number: 200) }
    exercise { '3' }
    sleep { '7' }
    cigarette { '6' }
    drinking { '3' }
  end
end
FactoryBot.define do
  factory :message do
    body { Faker::Lorem.characters(number: 200) }
  end
end
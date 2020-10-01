FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number: 200) }
  end
end

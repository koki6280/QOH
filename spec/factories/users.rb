FactoryBot.define do
  factory :user do
    nickname { 'fake' }
    email { Faker::Internet.free_email }
    profile { Faker::Lorem.characters(number: 50) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
FactoryGirl.define do
  factory :user do
    nickname { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email }
    password 'password'
    password_confirmation 'password'
  end
end

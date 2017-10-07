FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraphs(rand(2..5)).join('\n') }
    published_at { DateTime.now + rand(1..30).minutes }
    association :author, factory: :user
    post
  end
end

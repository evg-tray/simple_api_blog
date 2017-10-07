FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.words(rand(2..5)).join(' ') }
    body { Faker::Lorem.paragraphs(rand(2..5)).join('\n') }
    association :author, factory: :user
    published_at { DateTime.now + rand(1..30).minutes }
  end
end

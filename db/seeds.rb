# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

30.times do
  User.create(
      nickname: Faker::Internet.unique.user_name,
      email: Faker::Internet.unique.email,
      password: '1234',
      password_confirmation: '1234')
end

User.all.each do |user|
  rand(2..10).times do
    user.posts.create(
        title: Faker::Lorem.words(rand(2..5)).join(' '),
        body: Faker::Lorem.paragraphs(rand(2..5)).join('\n'),
        published_at: DateTime.now + rand(1..50).hours
    )
  end

  rand(2..10).times do
    user.comments.create(
        body: Faker::Lorem.paragraphs(rand(2..5)).join('\n'),
        published_at: DateTime.now + rand(1..50).hours,
        post: Post.offset(rand(Post.count)).first
    )
  end
end

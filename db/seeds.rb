# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Users
9.times do |n|
  name = Faker::FunnyName.name
  email = Faker::Internet.email
  password = 'abc123'
  icon = open("#{Rails.root}/test/fixtures/user_icons/user#{n % 9 + 1}.png")
  profile = Faker::Quotes::Shakespeare.as_you_like_it_quote
  user = User.new(
    name: name,
    email: email,
    icon: icon,
    profile: profile,
    password: password,
    password_confirmation: password
  )
  user.skip_confirmation!
  user.save!
end

# Sayings
all_users = User.all
all_users.each do |u|
  Random.rand(30).times do
    content = Faker::Quote.famous_last_words
    reference_id = Saying.all.sample.id if Random.rand(3).zero?
    u.sayings.create!(content: content,
                      created_at: Random.rand(1000).hours.ago,
                      reference_id: reference_id)
  end
end

# Relationships
all_users.each do |u|
  following = all_users.sample(Random.rand(all_users.count))
  following.each { |followed| u.follow(followed) }
end

# Favorites
all_users.each do |u|
  Random.rand(20).times do
    saying = Saying.all.sample
    Random.rand(100).times do
      u.like(saying)
    end
  end
end

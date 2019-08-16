# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

50.times do |n|
	name          = Faker::FunnyName.name
	email         = Faker::Internet.email
	password      = "abc123"
	icon					= Faker::Avatar.image(size: "200x200")
	profile       = Faker::Quotes::Shakespeare.as_you_like_it_quote
	User.create!(name:                  name,
               email:                 email,
							 icon:                  icon,
							 profile:               profile,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
20.times do
  content = Faker::Quote.famous_last_words
  users.each { |user| user.sayings.create!(content: content) }
end

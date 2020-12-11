# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do
  User.create!(first_name: "example_first", last_name: "example_last", email: "email@example.com")
  puts "User created."
end
3.times do
  User.create!(first_name: "example_first", last_name: "example_last", email: "zmail@example.com")
  puts "User created."
end
3.times do
  User.create!(first_name: "example_first", last_name: "example_last", email: "amail@example.com")
  puts "User created."
end

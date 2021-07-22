# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Author.destroy_all
Book.destroy_all

5.times do
  Author.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name) 
end

15.times do
  rand_author = rand(1...6)
  rand_pages =  rand(100...500)
  Book.create(title: Faker::Book.unique.title, publisher: Faker::Book.unique.publisher, genre: Faker::Book.unique.genre, pages: rand_pages, author_id: rand_author)
end 

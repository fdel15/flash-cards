# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ["Computer Science", "C", "Big Data", "Sabermetrics"]

categories.each {|c| Category.create(description: c)}

(1..50).each do |c|
  category = rand(4) + 1
  front = Card.create(description: "Test Front #{c}", category_id: category, front: true )
  back = Card.create(description: "Test Back #{c}", category_id: category, back: true, flip_side_id: front.id )
  front.update!(flip_side_id: back.id)
end

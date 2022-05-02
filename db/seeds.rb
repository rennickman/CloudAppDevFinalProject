# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



5.times do |x|
    Question.create(title: "super interesting question #{x}", body: "What is the the answer to 1 x #{x}", answer: "Well Done, it's #{x}")
end
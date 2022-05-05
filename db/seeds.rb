# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



# Create admin account
User.create(email: "renn@example.com", password: "password", password_confirmation: "password", name: "Ian", role: User.roles[:admin])

# Create user account
User.create(email: "billyBob@test.com", password: "password", password_confirmation: "password", name: "Bob")

# Create 5 questions
5.times do |x|
    question = Question.create(title: "Question #{x}", body: "What is the bla bla?", answer: "Bla Bla Bla Bla", user_id: User.first.id)

    # Create 5 comments for each question
    5.times do |y|
        Comment.create(body: "Comment #{y}", user_id: User.second.id, question_id: question.id)
    end
end

# Create 5 writings
5.times do |x|
    writing = Writing.create(title: "Writing #{x}", body: "HEEEEEEYYYAAAAAA", user_id: User.second.id)
end
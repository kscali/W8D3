# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{username: 'tommy'}, {username: 'mashu'}, {username: 'koy'}, {username: 'valery'}])
Poll.create([{title: 'Study', user_id: 4}, {title: 'Assessment', user_id: 2}])
AnswerChoice.create([{text: 'Monday', question_id: 1}, {text: 'Tuesday', question_id: 1}, 
    {text: 'NOO', question_id: 2}])
Question.create([{text: 'When is the next assessment?', poll_id: 2}, {text: 'Did you study?', poll_id: 1}])
Response.create([{user_id: 3, answer_choice_id: 1}, {user_id: 4, answer_choice_id: 2}, 
    {user_id: 3, answer_choice_id: 3}])

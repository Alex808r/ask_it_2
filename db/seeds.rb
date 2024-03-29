# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 30.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4) #=> "Vomito unde uxor annus. Et patior utilis sursum."
#   Question.create(title: title, body: body)
# end

# User.find_each { |user| user.send(:set_gravatar_hash); user.save }

30.times do
  title = Faker::Hipster.word
  Tag.create title: title
end

#
# p = 'P@ssw0rd$1'
#
# User.create email: 'tester@example.com',
#             name: 'test',
#             password: p,
#             password_confirmation: p
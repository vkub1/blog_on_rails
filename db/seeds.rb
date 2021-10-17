# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.destroy_all
Post.destroy_all


50.times do
    created_at = Faker::Date.backward(days:365 * 5)
    post = Post.create(
        title: Faker::Book.title,
        body: Faker::Lorem.paragraph_by_chars(number: rand(51..200), supplemental: false)
    )
    if post.valid?
        rand(1..5).times do
            Comment.create(
                body: Faker::Lorem.paragraph_by_chars(number: rand(51..200), supplemental: false),
                post: post
            )
        end
    end
end


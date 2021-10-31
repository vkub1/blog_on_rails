# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Comment.destroy_all
Post.destroy_all

PASSWORD = '123'

super_user = User.create(
    name: "Admin",
    email: "Admin@user.com",
    password: PASSWORD,
    is_admin: true
)

5.times do 
    name = Faker::Name.name
    User.create(
        name:name,
        email: "#{name}@gmail.com",
        password: PASSWORD
    )
end

users = User.all


50.times do
    created_at = Faker::Date.backward(days:365 * 5)
    post = Post.create(
        title: Faker::Book.title,
        body: Faker::Lorem.paragraph_by_chars(number: rand(51..200), supplemental: false),
        user: users.sample
    )
    if post.valid?
        rand(1..5).times do
            Comment.create(
                body: Faker::Lorem.paragraph_by_chars(number: rand(51..200), supplemental: false),
                post: post,
                user: users.sample
            )
        end
    end
end


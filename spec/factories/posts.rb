FactoryBot.define do
  factory :post do
    title {Faker::Book.title}
    body {Faker::Lorem.paragraph_by_chars(number: rand(51..100), supplemental: false)}
  end
end

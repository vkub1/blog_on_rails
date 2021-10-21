FactoryBot.define do
  factory :comment do
    body { "MyText" }
    association(:post, factory: :post)
  end
end

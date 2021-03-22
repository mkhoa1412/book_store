FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end

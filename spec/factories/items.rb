FactoryBot.define do
  factory :item do
    name           { Faker::Name.initials(number: 2) }
    description    { Faker::Lorem.sentence }
    category_id    { 3 }
    condition_id   { 3 }
    deliveryfee_id { 3 }
    area_id { 3 }
    days_id { 3 }
    price       { 10_000 }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

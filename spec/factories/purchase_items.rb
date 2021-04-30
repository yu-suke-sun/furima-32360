FactoryBot.define do
  factory :purchase_item do
    token            { 'tok_ca201f132ba3d85cf9f4bb8b927c' }
    postal_code      { '815-0082' }
    area_id          { 3 }
    municipality     { Faker::Address.city }
    address          { Faker::Address.street_address }
    telephone_number { '09065676655' }
    user_id { 1 }
    item_id { 5 }
  end
end

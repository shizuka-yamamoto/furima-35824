FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    house_number { '111' }
    building_name { '東京ハイツ' }
    phone_number { '08012345678' }
  end
end
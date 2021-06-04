FactoryBot.define do
  factory :item do
    item_name { 'Tシャツ' }
    description { 'おしゃれ' }
    category_id { 2 }
    condition_id { 2 }
    postage_id { 2 }
    shipping_area_id { 2 }
    handling_time_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

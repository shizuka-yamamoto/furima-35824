class Item < ApplicationRecord
	extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
	belongs_to :condition
	belongs_to :postage
	belongs_to :shippingarea
	belongs_to :handlingtime
	belongs_to :user
	has_one_attached :image
	
	with_options presence: true do
		validates :image
    validates :item_name
    validates :description
		validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid. Input half-width characters
			"}
	end
	with_options numericality: { other_than: 1, message: "can't be blank" } do
		validates :category_id
		validates :condition_id
		validates :postage_id
		validates :shipping_area_id
		validates :handling_time_id
	end
	
end
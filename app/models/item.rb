class Item < ApplicationRecord
	extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
	belongs_to :condition
	belongs_to :postage
	belongs_to :shipping_area
	belongs_to :handling_time

	with_options presence: true do
    validates :item_name
    validates :description
		validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
	end
	with_options numericality: { other_than: 1 } do
		validates :category_id
		validates :condition_id
		validates :postage_id
		validates :shipping_area_id
		validates :handling_time_id
	end

	belongs_to :user
	
end

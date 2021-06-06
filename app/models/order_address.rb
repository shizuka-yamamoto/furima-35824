class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number, :item_id, :user_id

	with_options presence: true do
    validates :order_id
		validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
		validates :city
		validates :house_number
		validates :phone_number,format: {with: /\A\d{10,11}\z/ }
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

	def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end
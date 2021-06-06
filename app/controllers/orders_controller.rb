class OrdersController < ApplicationController
	before_action :authenticate_user!, only: [:index, :create]
	before_action :set_order, only: [:index, :create]
	before_action :sold_out_item, only: [:index, :create]
	before_action :block_order_page, only: [:index, :create]

	def index
		redirect_to root_path	if current_user == @item.user
		@order_address = OrderAddress.new
	end

	def create
		if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
	end

	private

	def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
	end

	def set_order
		@item = Item.find(params[:item_id])
	end

	def sold_out_item
		redirect_to root_path if @item.order.present?
	end

	def block_order_page
		@order_address = OrderAddress.new(order_params)
	end

end
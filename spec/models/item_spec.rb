require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品商品の登録' do
    context '出品商品情報が登録できる場合' do
      it 'image、item_name、description、category_id、condition_id、postage_id、shipping_area_id、handling_time_id、priceがあれば投稿できる' do
        expect(@item).to be_valid
      end
      it 'priceが¥300~¥9,999,999の間であれば登録できる' do
        @item.price >= 300 && @item.price <= 9999999
        expect(@item).to be_valid
      end
      it 'priceが半角数値であれば登録できる' do
        @item.price = 1000
        expect(@item).to be_valid
      end
      it 'category_idがid:1以外であれば登録できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'condition_idがid:1以外であれば登録できる' do
        @item.condition_id = 2
        expect(@item).to be_valid
      end
      it 'postage_idがid:1以外であれば登録できる' do
        @item.postage_id = 2
        expect(@item).to be_valid
      end
      it 'shipping_area_idがid:1以外であれば登録できる' do
        @item.shipping_area_id = 2
        expect(@item).to be_valid
      end
      it 'handling_time_idがid:1以外であれば登録できる' do
        @item.handling_time_id = 2
        expect(@item).to be_valid
      end
    end
    context '出品商品情報が投稿できない場合' do
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it 'imageがなければ登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end 
      it 'item_nameが空では登録できない' do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end 
      it 'descriptionが空では登録できない' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end 
      it 'category_idがid:1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end 
      it 'condition_idがid:1では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end 
      it 'postage_idがid:1では登録できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end 
      it 'shipping_area_idがid:1では登録できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area can't be blank")
      end 
      it 'handling_time_idがid:1では登録できない' do
        @item.handling_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Handling time can't be blank")
      end 
      it 'priceが空では登録できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end 
      it 'priceが¥299以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it 'priceが¥10000000以上では登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it 'priceが全角数値であると登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
    end
  end
end

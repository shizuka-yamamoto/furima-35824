require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報保存' do
    before do
      user = FactoryBot.create(:user)
			item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
			sleep 0.1 
    end

    context '登録内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
				expect(@order_address).to be_valid
      end
			it '郵便場号は3桁ハイフン4桁の半角文字列なら登録できる' do
				@order_address.postal_code = '123-4567'
				expect(@order_address).to be_valid
      end
			it 'prefecture_idがid:1以外であれば登録できる' do
				@order_address.prefecture_id = 2
        expect(@order_address).to be_valid
			end
			it 'building_nameは空でも保存できること' do
				@order_address.building_name =  ''
				expect(@order_address).to be_valid
      end
      it '電話番号が10桁か11桁の半角数値なら保存できる' do
				@order_address.phone_number = '08012345678' 
      end
    end

    context '登録内容に問題がある場合' do
			it "tokenが空では登録できないこと" do
				@order_address.token = nil
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Token can't be blank")
			end
			it 'postal_codeが空だと保存できないこと' do
				@order_address.postal_code = ''
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
				@order_address.postal_code = '1234567'
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'prefecture_idが1であると保存できないこと' do
				@order_address.prefecture_id = 1
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
			it 'cityが空だと保存できないこと' do
				@order_address.city = ''
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
			it 'house_numberが空だと保存できないこと' do
				@order_address.house_number = ''
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
			it 'phone_numberが空だと保存できないこと' do
				@order_address.phone_number = ''
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
			it 'phone_numberが9桁以下だと保存できないこと' do
				@order_address.phone_number = '080123456'
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
			it 'phone_numberが12桁以上だと保存できないこと' do
				@order_address.phone_number = '080123456789'
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Phone number is invalid")
			end
			it 'phone_numberが半角数値でないとだと保存できないこと' do
				@order_address.phone_number = '０８０１２３４５６７８'
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberにハイフンが入っていると保存できないこと' do
				@order_address.phone_number = '080-1234-5678'
				@order_address.valid?
				expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'userが紐付いていないと保存できないこと' do
				@order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
			it 'itemが紐付いていないと保存できないこと' do
				@order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
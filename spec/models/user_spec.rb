require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_name、first_name、last_name_kana、first_name_kana、birth_dayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailが一意性であれば登録できる' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email != @user.email
        expect(@user).to be_valid
      end
      it 'emailが@を含めば登録できる' do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationは6文字以上であれば登録できる' do
        @user.password = '1a1a1a'
        @user.password_confirmation = '1a1a1a'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationは英数混合であれば登録できる' do
        @user.password = '1a1a1a'
        @user.password_confirmation = '1a1a1a'
        expect(@user).to be_valid
      end
      it 'last_nameが全角(漢字・ひらがな・カタカナ)であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end
      it 'first_nameが全角(漢字・ひらがな・カタカナ)であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角(カタカナ)であれば登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角(カタカナ)であれば登録できる' do
        @user.first_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'abcabc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '1a1a1a'
        @user.password_confirmation = '1a1a1a1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが5文字以下では登録できない' do
        @user.password = '1a1a1'
        @user.password_confirmation = '1a1a1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは英数字混合でないと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  is invalid. Include both letters and numbers')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角(漢字・ひらがな・カタカナ)でなければ登録できない' do
        @user.last_name = 'hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name  is invalid. Input full-width characters')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角(漢字・ひらがな・カタカナ)でなければ登録できない' do
        @user.first_name = 'hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name  is invalid. Input full-width characters')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaが全角(カタカナ)でなければ登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana  is invalid. Input full-width katakana characters')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaが全角(カタカナ)でなければ登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana  is invalid. Input full-width katakana characters')
      end
      it 'birth_dayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end

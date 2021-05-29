require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, item_id: item.id, user_id: user.id )
      sleep 0.1
    end

    context '情報が保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
      sleep 0.1
    end

    context '情報が保存できない場合' do
      it 'tokenが空では保存できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空だと保存できないこと' do
        @purchase_address.postal_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んでないと保存できないこと' do
        @purchase_address.postal_code = "1234567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code はハイフンを含む半角英数字で入力してください")
      end

      it 'postal_codeは半角英字の場合保存できないこと' do
        @purchase_address.postal_code = "aaa-aaaa"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code はハイフンを含む半角英数字で入力してください")
      end

      it 'postal_codeは全角数字の保存できないこと' do
        @purchase_address.postal_code = "１２３-４５６７"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code はハイフンを含む半角英数字で入力してください")
      end

      it 'postal_codeは全角ひらがなの場合保存できないこと' do
        @purchase_address.postal_code = "あいう-えおかき"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code はハイフンを含む半角英数字で入力してください")
      end

      it 'postal_codeは全角カタカナの場合保存できないこと' do
        @purchase_address.postal_code = "アイウ-エオカキ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code はハイフンを含む半角英数字で入力してください")
      end

      it 'prefectureを選択していないと保存できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture を選択してください")
      end

      it 'cityが空の場合だと保存できないこと' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空だと保存できないこと' do
        @purchase_address.house_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_address.phone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は11桁以内の半角数字で入力してください")
      end

      it 'phone_numberは12桁以上の半角数字だと保存できないこと' do
        @purchase_address.phone_number = "123456789012"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end

      it 'phone_numberは半角英字だと保存できないこと' do
        @purchase_address.phone_number = "abcdefghijk"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は11桁以内の半角数字で入力してください")
      end

      it 'phone_numberは全角数字だと保存できないこと' do
        @purchase_address.phone_number = "１２３４５６７８９０１"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は11桁以内の半角数字で入力してください")
      end

      it 'phone_numberは全角ひらがなだと保存できないこと' do
        @purchase_address.phone_number = "あいうえおかきくけこさ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は11桁以内の半角数字で入力してください")
      end

      it 'phone_numberは全角カタカナだと保存できないこと' do
        @purchase_address.phone_number = "アイウエオカキクケコサ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は11桁以内の半角数字で入力してください")
      end

      it 'itemと紐づいていないと保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが空の場合保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
    end 
  end
end

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end
    describe "出品登録" do

      context '商品が出品できるとき' do
        it 'name, image, description, price, condition_id, category_id, shipping_burden_id, prefecture_id, shipping_date_idの存在があれば出品できること' do
          expect(@item).to be_valid
        end
      end

      context '商品が出品できないとき' do
        
        it 'nameが空では出品できないこと' do
          @item.name = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it 'descriptionが空では出品できないこと' do
          @item.description = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end

        it 'priceが空では出品できないこと' do
          @item.price = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it 'category_idが選択されていないと出品できないこと' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category を選択してください")
        end

        it 'condition_idが選択されていないと出品できないこと' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition を選択してください")
        end

        it 'shipping_burden_idが選択されていないと出品できないこと' do
          @item.shipping_burden_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping burden を選択してください")
        end

        it 'prefecture_idが選択されていないと出品できないこと' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture を選択してください")
        end

        it 'shipping_date_idが選択されていないと出品できないこと' do
          @item.shipping_date_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping date を選択してください")
        end

        it 'priceが全角ひらがなの場合出品できないこと' do
          @item.price = "あいうえお"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は半角数字で入力してください")
        end

        it 'priceが全角カタカナの場合出品できないこと' do
          @item.price = "アイウエオ"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は半角数字で入力してください")
        end

        it 'priceが全角漢字の場合出品できないこと' do
          @item.price = "焼肉定食"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は半角数字で入力してください")
        end

        it 'priceが全角数字の場合出品できないこと' do
          @item.price = "１２３４５"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は半角数字で入力してください")
        end

        it 'priceが半角英語の場合出品できないこと' do
          @item.price = "abcde"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は半角数字で入力してください")
        end

        it 'priceが全角英数混合の場合出品できないこと' do
          @item.price = "123abc"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は半角数字で入力してください")
        end

        it 'priceが300円未満の場合出品できないこと' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は300円以上9,999,999円以下を入力してください")
        end

        it 'priceが10,000,000円以上の場合出品できないこと' do
          @item.price = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price は300円以上9,999,999円以下を入力してください")
        end
      end
    end
  end
end

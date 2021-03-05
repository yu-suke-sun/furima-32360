require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品が登録できる時' do
      it '値が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end

      it 'priceが¥300~¥9,999,999の間であり、半角数字で入力されていれば登録できる' do
        @item.price = 100_000
        expect(@item).to be_valid
      end
    end

    context '商品が登録できない時' do
      it '商品画像がnilの時は登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空の時は登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionが空の時は登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idの情報が「---」だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'condition_idの情報が「---」だと登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      it 'deliveryfee_idの情報が「---」だと登録できない' do
        @item.deliveryfee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Deliveryfee must be other than 1')
      end

      it 'area_idの情報が「---」だと登録できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Area must be other than 1')
      end

      it 'days_idの情報が「---」だと登録できない' do
        @item.days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Days must be other than 1')
      end

      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが¥300~¥9,999,999の間でないと登録できない' do
        @item.price = 10
        @item.valid?
        expect(@item.errors.full_messages).to include('Price ¥300〜9,999,999内で入力してください')
      end

      it 'priceが半角数字のみでないと登録できない' do
        @item.price = '12３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 半角数字で入力してください')
      end

      it 'priceが半角英数混合では登録できない' do
        @item.price = '12as12'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 半角数字で入力してください')
      end

      it 'priceが半角英語だけでは登録できない' do
        @item.price = 'price'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 半角数字で入力してください')
      end

      it 'priceが¥10,000,000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price ¥300〜9,999,999内で入力してください')
      end

      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

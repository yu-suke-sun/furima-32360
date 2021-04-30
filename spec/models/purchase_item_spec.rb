require 'rails_helper'

RSpec.describe PurchaseItem, type: :model do
  describe '商品購入機能' do
    before do
      @purchase_item = FactoryBot.build(:purchase_item)
      @purchase_item.user_id = FactoryBot.build(:user)
      @purchase_item.item_id = FactoryBot.build(:item)
    end

    context '商品が購入できる時' do
      it '値が正しく入力されていれば購入できる' do
        expect(@purchase_item).to be_valid
      end
      it '建物名が抜けていても購入できる' do
        @purchase_item.building_name = nil
        expect(@purchase_item).to be_valid
      end
    end

    context '商品が購入できない時' do
      it 'tokenがnilの時は購入できない' do
        @purchase_item.token = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeがnilの時は購入できない' do
        @purchase_item.postal_code = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンがない時は購入できない' do
        @purchase_item.postal_code = '8150082'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Postal code Input correctly')
      end
      it 'area_idがnilの時は購入できない' do
        @purchase_item.area_id = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Area Select')
      end
      it 'area_idが１の時は購入できない' do
        @purchase_item.area_id = '1'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Area Select')
      end
      it 'municipalityがnilの時は購入できない' do
        @purchase_item.municipality = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressがnilの時は購入できない' do
        @purchase_item.address = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Address can't be blank")
      end
      it 'telephone_numberがnilの時は購入できない' do
        @purchase_item.telephone_number = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberにハイフンがある時は購入できない' do
        @purchase_item.telephone_number = '0120-822212'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number Input only number')
      end
      it 'telephone_numberが12桁以上だと購入できない' do
        @purchase_item.telephone_number = '012012345676'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number Input only number')
      end
      it 'telephone_numberは英数混合では購入できない' do
        @purchase_item.telephone_number = '012s01234ab'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number Input only number')
      end
      it 'user_idが紐付いてないと購入できない' do
        @purchase_item.user_id = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐付いてないと購入できない' do
        @purchase_item.item_id = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

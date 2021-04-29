class PurchasesController < ApplicationController

  before_action :set_item, only: [:index, :create]

  def index
    @purchase = PurchaseItem.new
  end

  def create
    @purchase = PurchaseItem.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_item).permit(:postal_code, :area_id, :municipality, :address, :building_name, :telephone_number, :purchase_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]

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
    params.require(:purchase_item).permit(:postal_code, :area_id, :municipality, :address, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    redirect_to root_path if @item.purchase.present? || current_user.id == @item.user_id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end

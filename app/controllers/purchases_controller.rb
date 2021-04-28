class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase = PurchaseItem.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = PurchaseItem.new(purchase_params)
    if @purchase.valid?
      @purchase.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_item).permit(:postal_code, :area_id, :municipality, :address, :building_name, :telephone_number, :purchase_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
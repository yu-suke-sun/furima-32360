class ItemsController < ApplicationController
  before_action :move_to_session, except: [:index]

  def index
  end

  def new
    @items = Item.new
  end

  def create
    @items = Item.new(item_params)
    if @items.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :deliveryfee_id, :area_id, :days_id, :price,
                                 :image).merge(user_id: current_user.id)
  end

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end
end

class PurchasesController < ApplicationController
  def index
    @purchase = PurchaseItem.new
  end
end

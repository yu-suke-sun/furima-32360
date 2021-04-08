class Purchaseitem
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipality, :address, :building_name, :telephone_number, :purchase_id, :user_id, :item_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :area_id
    validates :municipality
    validates :address
    validates :telephone_number
    validates :purchase_id
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Delivery.create(postal_code: postal_code, area_id: area_id, municipality: municipality, address: address, building_name: building_name, purchase_id: purchase_id)
  end

 
end
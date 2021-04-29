class PurchaseItem
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipality, :address, :building_name, :telephone_number, :purchase_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :area_id, numericality: { other_than: 1, message: 'Select' }
    validates :municipality
    validates :address
    validates :telephone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'Input only number' }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Delivery.create(postal_code: postal_code, area_id: area_id, municipality: municipality, address: address, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)
  end

 
end
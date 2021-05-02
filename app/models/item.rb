class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :deliveryfee
  belongs_to :area
  belongs_to :days

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :deliveryfee_id
    validates :area_id
    validates :days_id
  end

  validates :price, numericality: { only_integer: true, message: '半角数字で入力してください' }

  validates :price, numericality: { greater_than: 299, less_than: 10_000_000, message: '¥300〜9,999,999内で入力してください' }

  belongs_to :user
  has_one_attached :image
  has_one :purchase
end

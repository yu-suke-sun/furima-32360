class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :deliveryfee
  belongs_to :area
  belongs_to :days

  with_options presence: true, do
    validates :name
    validates :description
    validates :price
  end

  with_options numericality: { other_than: 1 }  do
    validates :category_id
    validates :condition_id
    validates :deliveryfee_id
    validates :area_id
    validates :days_id
  end

  validates :price, numericality: { greater_than: 300, less_than: 9999999, message: '¥300〜9,999,999内で入力してください' }

  validates :price, format: { with: /^[0-9]+$/, message: '半角数字を使用してください' }

  belongs_to :user
end

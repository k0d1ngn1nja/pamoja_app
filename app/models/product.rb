class Product < ActiveRecord::Base
  validates :name, :description, :category, :price, presence: true
  belongs_to :seller
  belongs_to :buyer
  has_many :images
  validates :price, numericality:{greater_than: 0}
  has_one :item
end

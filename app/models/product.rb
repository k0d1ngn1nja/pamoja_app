class Product < ActiveRecord::Base
  validates :name, :description, :category, :price, presence: true
  belongs_to :seller
  belongs_to :buyer
  has_many :images
  validates :price, numericality:{only_integer: true}
end

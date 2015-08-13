class Product < ActiveRecord::Base
  belongs_to :seller
  belongs_to :buyer
  has_many :images
end

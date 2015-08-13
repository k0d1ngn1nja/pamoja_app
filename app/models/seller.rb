class Seller < ActiveRecord::Base
  mount_uploader :image, ProductUploader 
  has_many :products  
end

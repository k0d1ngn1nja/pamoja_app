class Seller < ActiveRecord::Base
 mount_uploader :image, SellerUploader
  has_many :products  
end

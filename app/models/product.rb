class Product < ActiveRecord::Base
 mount_uploader :image, ProductUploader  
  belongs_to :seller
  belongs_to :buyer
end

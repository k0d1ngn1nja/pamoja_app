class SellerUploader < CarrierWave::Uploader::Base
 storage :image

 def store_dir
   'images'
 end
end


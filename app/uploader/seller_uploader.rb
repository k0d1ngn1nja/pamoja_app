class SellerUploader < CarrierWave::Uploader::Base
  storage :image

  def store_dir
    'seller_images'
  end
end
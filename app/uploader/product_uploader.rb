class ProductUploader < CarrierWave::Uploader::Base
  storage :image

  def store_dir
    'product_images'
  end
end
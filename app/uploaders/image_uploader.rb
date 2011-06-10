class ImageUploader < CarrierWave::Uploader::Base 
  def cache_dir
   "#{Rails.root}/tmp/uploads"
  end
  
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end

class ImageUploader < CarrierWave::Uploader::Base 
  def cache_dir
    if Rails.env.production?
      "#{Rails.root}/tmp/uploads"
    else
      super
    end
  end
  
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end

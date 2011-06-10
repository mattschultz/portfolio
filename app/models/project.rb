class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, type: String
  field :url, type: String
  field :description, type: String
  field :image, type: String
  field :position, type: Integer
  
  mount_uploader :image, ImageUploader
  
  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :description
  validates_format_of :url, with: /^(#{URI::regexp(%w(http https))})$|^$/
  
  default_scope order_by([:position, :asc])
end

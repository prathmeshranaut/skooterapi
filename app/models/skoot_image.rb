class SkootImage < ActiveRecord::Base
  belongs_to :skoot

  has_attached_file :image,
    :styles => {:small => "300x300>" },
    :storage => :s3,
    :path => "skoot_image/:user_id_skoot/:id/:random_string_skoot_:time_:style.:extension"

  validates_attachment :image, :presence => true,
    :content_type => { :content_type => ["image/jpeg", "image/png"] },
  	:size => { :in => 0..2000.kilobytes }
end

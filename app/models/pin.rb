class Pin < ActiveRecord::Base
    belongs_to :user

		# attr_accessor :image_file_name
		# attr_accessor :image_content_type
		# attr_accessor :image_file_size
		# attr_accessor :image_updated_at

  	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 		validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
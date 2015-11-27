class Pin < ActiveRecord::Base
		require 'csv'

    belongs_to :user

  	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 		validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  	#validates :description, presence: true


  def self.import(file, user_id)
  	CSV.foreach(file.path, headers: true) do |row|
		Pin.create! row.to_hash.merge(user_id: user_id, created_at: Time.now)
  	end
	end 


	def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
    	csv << column_names
    	all.each do |product|
      	csv << product.attributes.values_at(*column_names)
    	end
  	end
	end

end


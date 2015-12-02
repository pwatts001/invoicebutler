class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins, dependent: :destroy

  #validates :company, presence: true
  require 'csv'

	def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
    	csv << column_names
    	all.each do |product|
      	csv << product.attributes.values_at(*column_names)
    	end
  	end
	end

  
end

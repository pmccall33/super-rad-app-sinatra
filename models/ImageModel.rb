class Image < ActiveRecord::Base 
	belongs_to :user_path_step
	has_many :tags
end	
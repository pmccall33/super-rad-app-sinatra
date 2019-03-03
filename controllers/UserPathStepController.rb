class UserPathStepController < ApplicationController

	#get image

		
	get '/' do 
		puts "hit the user_path route &(*($&------"

		# # get a random image url from database  
		# rand_image = Image.all.sample 

		# @image_url = ""

		# if rand_image 
		# 	@image_url = rand_image.image_url
		# 	@image_id = rand_image.id 
		# end 

		erb :user_path
	end
end
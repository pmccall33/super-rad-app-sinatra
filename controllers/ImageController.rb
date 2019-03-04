class ImageController < ApplicationController

	before ['/new', '/submit', '/destroy', '/find', '/display'] do
		if not (session[:logged_in] and session[:is_admin])
			session[:message] = "You must be logged in as an administrator to do that!"
			redirect '/admin/login'
		end
	end

	get '/' do
		# get a random image url from database
		rand_image = Image.all.sample

		@image_url = ""

		# Or, in one word, describe... 
		prompts = [
			"how this image makes you feel",
			"the color you associate with this image",
			"the layout or composition of the image",
			"the subject depicted in this image",
			"what fruit this image would be, if it were a fruit",
			"what name this image would have, if it had a name",
			"the first thing that comes to mind when you see this image"
		]

		@prompt = "Oops! Error loading image. Click SKIP and move on."

		if rand_image
			@prompt = prompts.sample 
			@image_url = rand_image.image_url
			@image_id = rand_image.id
		end

		erb :show_image
	end


	get '/new' do
		erb :new_image
	end


	post '/submit' do
		@image_url = params[:image_url]

		erb :submit_image
	end


	post '/new' do
		image = Image.new
		image.image_url = params[:image_url]
		image.save

		session[:message] = "Successfully added image!"

		redirect '/image/new'
	end


	post '/' do
		redirect '/'
	end


	get '/find' do 
		erb :find_images 
	end


	post '/display' do 
		
		puts "paramsID: "
		pp params[:id]

		puts "params url query: "
		pp params[:query]


		if params[:id]  
			@images = [Image.find(params[:id])]
		end

		if params[:query] 

			all_images = Image.all 

			@images = [] 

			all_images.each do |image| 
				if image.image_url.include?(params[:query])  
					@images.push(image)
				end
			end
		end

		puts "@images: "
		pp @images 
		puts " "

		erb :display_images
	end


	# get "/bad_image" do
	# 	puts "bad_image route reached"
	# 	puts "=====all Images"
	# 	@all_images = Image.all

	# 	response = {
	# 		success: true,
	# 		code: 200,
	# 		status: "good",
	# 		message: "get bad_image route and response",
	# 		images: @all_images
	# 	}
	# 	response.to_json
	# end

	delete '/destroy/:id' do 

		puts "DELETE ROUTE HIT: "
		puts "Delete image ${params[:id]}" 

		# below code caused error message we couldn't bugfix -- NLS 
		# ================================================
		# image_to_delete = Image.find(params[:id].to_i)

		# image_to_delete.destroy 
		# ================================================
		
		redirect '/image/find'
	end


	post '/:id' do

		puts "params are here: "
		pp params

		tag_candidate = params[:tag].downcase 

		tag_candidate = tag_candidate.tr("\n", "")

		unless (/[^A-z]+/ =~ params[:tag].strip)
			puts "this works"

			tag_candidate = tag_candidate.strip.downcase

			if not (tag_candidate.length <= 1 || tag_candidate.length >= 15)
				new_tag = Tag.new
				new_tag.image_id = params[:id]
				new_tag.image_tag = tag_candidate 

				new_tag.save
			end 
		end

		session[:message] = "Thank you for the input!"
		redirect '/image'
	end
end

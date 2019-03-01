class ImageController < ApplicationController

	before ['/new', '/submit'] do
		if not (session[:logged_in] and session[:is_admin])
			session[:message] = "You must be logged in as an administrator to do that!"
			redirect '/admin/login'
		end
	end


	get '/' do
		# get a random image url from database
		rand_image = Image.all.sample

		@image_url = ""

		if rand_image
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

		message[:session] = "Thank you for the input!"
		redirect '/image'
	end


	post '/' do
		redirect '/'
	end

end

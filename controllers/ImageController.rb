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
		puts "#{params} are herereereeee!"
		if (params[:tag] and params[:tag].length > 0)
			new_tag = Tag.new 
			new_tag.image_id = params[:id] 
			new_tag.image_tag = params[:tag] 

			new_tag.save
			session[:message] = "Successfully added your tag!" 
		end 

		redirect '/image'
	end


	post '/' do 
		redirect '/'
	end

end
class ImageAPIController < ApplicationController

	before do
    if request.post?
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload"
			pp @payload
		end
	end

	get '/test' do
		puts "TEst GET  ImageAPI route reached!!!!"
		response = {
			success: true,
			code: 200,
			status: "good",
			message: "test Image route reached"
		}
		response.to_json
	end

	post '/test' do
		puts "TEst POST ImageAPI route reached!!!!"
		response = {
			success: true,
			code: 200,
			status: "good",
			message: "test route reached"
		}
		response.to_json
  	end

	get '/random' do
		# get a random image url from database
		rand_image1 = Image.all.sample
		rand_image2 = Image.all.sample
		rand_image3 = Image.all.sample
		rand_image4 = Image.all.sample

		# @image_url = ""

		@rand_image_arr = [rand_image1, rand_image2, rand_image3, rand_image4] 

		response = {
			success: true,
			code: 200,
			status: "good",
			message: "get rndom image route success, returning array of images",
			rand_image_arr: @rand_image_arr
		}
		response.to_json
	end

	get '/:id' do
		image = Image.find_by id: params[:id]
		@image_id = image.id
		@image_url = image.image_url
		response = {
			success: true,
			code: 200,
			status: "good",
			message: "get image by :id returns",
			image_id: @image_id,
			image_url: @image_url
		}
		response.to_json
	end

	get '/:id' do
		image = Image.find_by id: params[:id]

		@image_id = image.id
		@image_url = image.image_url

		response = {
			success: true,
			code: 200,
			status: "good",
			message: "get image by :id route success",
			image_id: @image_id,
			image_url: @image_url
		}
		response.to_json
	end

	before ['/new', '/submit'] do
		if not (session[:logged_in] and session[:is_admin])
			session[:message] = "You must be logged in as an administrator to do that!"
			redirect '/admin/login'
		end
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
		if (params[:tag] and params[:tag].length > 0)
			new_tag = Tag.new
			new_tag.image_id = params[:id]
			new_tag.image_tag = params[:tag]
			new_tag.save
		end
		redirect '/image'
	end

	post '/' do
		redirect '/'
	end
end

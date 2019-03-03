class ImageAPIController < ApplicationController

	# ======================
	# ADMIN FILTER: 
	before ['/new', '/submit'] do
		if not (session[:logged_in] and session[:is_admin])
			session[:message] = "You must be logged in as an administrator to do that!"
			redirect '/admin/login'
		end
	end
	# ======================


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

		all_image_tags = Tag.all

		puts "ALL_IMAGE_TAGS: "
		print all_image_tags

		if !all_image_tags || all_image_tags.length == 0 
			response = {
				success: false,
				code: 200,
				status: "bad",
				message: "no tags",
			}

			response.to_json
		else 

			this_image_tags = []

			all_image_tags.each do |tag|
				if tag.image_id == image.id 
					this_image_tags.push(tag)
				end
			end

			if !this_image_tags or this_image_tags.length == 0 
				response = {
					success: false,
					code: 200,
					status: "bad",
					message: "no tags for that image",
				}

				response.to_json
			else

				selected_tags = []

				selected_tags.push(this_image_tags.sample)
				selected_tags.push(this_image_tags.sample)
				selected_tags.push(this_image_tags.sample)
				selected_tags.push(this_image_tags.sample)

				puts "SELECTED TAGS: "
				print selected_tags

				related_images_ids = []

				all_image_tags.each do |tag| 
					if selected_tags.include? tag.tag
						related_images_ids.push tag.image_id
					end
				end

				if !related_images_ids or related_images_ids.length == 0 
					response = {
						success: false,
						code: 200,
						status: "bad",
						message: "no related image ids for that tag",
					}

					response.to_json				

				else 

				selected_images_ids = []

					selected_images_ids.push(related_images_ids.sample)
					selected_images_ids.push(related_images_ids.sample)
					selected_images_ids.push(related_images_ids.sample)
					selected_images_ids.push(related_images_ids.sample)

					puts "SELECTED IMAGES IDS: "
					print selected_images_ids

					@image_arr = Images.find(selected_images_ids)

					response = {
						success: true,
						code: 200,
						status: "good",
						message: "returning array of selected images",
						image_arr: @image_arr
					}

					response.to_json
				end
			end
		end
	end



	# ===========================================
	# ADMIN STUFF 

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

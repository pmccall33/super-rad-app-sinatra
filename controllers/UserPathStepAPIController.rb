class UserPathStepAPIController < ApplicationController

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
			message: "test UserPathStepAPIController route reached"
		}
		response.to_json
  	end

  	post '/' do
  		puts "here lies the POST route in UserPathStepAPIController, young grasshopper!"
  		pp @payload 
	  		user_path_step = UserPathStep.find_by path_id: @payload[:path_id]
	  		pp "#{user_path_step} <---- user_path_step is here !!!!"
  		# if (session[:logged_in] = true and session[:username] = user.username)
	  	# 	puts "this is user #{user}"

	  		@user_path_step = UserPathStep.new
		  	@user_path_step.user_id = @payload[:user_id]
			@user_path_step.image_id = @payload[:image_id]
			@user_path_step.path_id = @payload[:path_id]
			@user_path_step.previous_step = @payload[:user_id]

			@user_path_step.save
			puts "#{user_path_step} after save is right here <-----------"
  		# end

  		response = {
			success: true,
			code: 201,
			status: "good",
			message: "Successfully created #{user_path_step}",
			user_path_step: @user_path_step
		}
		response.to_json
	end

  	get '/:id' do 
		
  		if (session[:logged_in] = true and session[:username] = user.username)

			@user_path_step = UserPathStep.find_by id: params[:id]				

			# @user_path_step 
			# image_id = image.id
			# image_url = image.image_url
			
		end
		response = {
			success: true,
			code: 200,
			status: "good",
			message: "Successfully found #{user_path_step}",
			user_path_step: @user_path_step
		}
		response.to_json
	end


end







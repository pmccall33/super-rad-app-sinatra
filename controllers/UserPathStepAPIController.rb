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

	get '/:id/all' do
		puts "reached UserPathStepAPIController /all route"
		# if (session[:logged_in] = true and session[:username] = user.username)
			puts "#{params} <=== params from /all are here"

			puts "#{params[:id]} <=== params[:id] from /all are here"
			# puts "#{UserPathStep.path_id}"
			# path_id = params[:id]
			# puts "#{path_id} path_id hreerererererer"
			@user_path = UserPathStep.find_by path_id: params[:id]
			# @user_path_arr = UserPathStep.find_each path_id: params[:id]
			# @user_path_arr = UserPathStep.find_each do |step|
			# 	step == path_id
			# end
				 # Person.find_each(:conditions => "age > 21") do |person|
				 #    person.party_all_night!
				 #  end
			# @user_path_arr = UserPathStep.find_each(:path_id => params[:id]) do |step|

			# end

			# @user_path_arr = UserPathStep.find_each { |path_id| path_id == params[:id] }

			@user_path_arr = []
			@path_id = params[:id]

			UserPathStep.find_each(:path_id => "path_id == #{@path_id}") do |path_id|
				puts "here are find_each vars ============"
				puts "#{path_id} path_id"
				puts "#{params[:id]} params[:id] is herrererere"
				@user_path_arr.push(path_id)
			end

			puts "@user_path_arr"
			pp @user_path_arr
		# end
		response = {
			success: true,
			code: 200,
			status: "good",
			message: "Successfully found #{@user_path_arr}",
			user_path: @user_path_arr
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







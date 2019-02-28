class UserAPIController < ApplicationController

	before do
	    if request.post?
			payload_body = request.body.read
			@payload = JSON.parse(payload_body).symbolize_keys
			puts "---------> Here's our payload"
			pp @payload

		end
  	end

  	post '/test' do
  		"TEst route reached"
  		response = {
				success: true,
				code: 200,
				status: "good",
				message: "test route reached"
			}
			response.to_json

  	end

  	post '/login' do
  		puts "hitting the route"
  		user = User.find_by username: @payload[:username]

  		pw = @payload[:password]

		if user and user.authenticate(pw)
			session[:logged_in] = true
			session[:username] = user.username


			# NEW CODE ===============
			# CHECK IF ADMIN, SET PERMISSIONS VIA SESSIONS, CHANGE MESSAGE 
			admin_message = ""

			if user.is_admin 
				session[:is_admin] = true 
				admin_message = "administrator: "
			end
			# NEW CODE ===============

			response = {
				success: true,
				code: 200,
				status: "good",
				message: "Logged in as #{admin_message}#{user.username}",
				username: user.username
			}
			response.to_json
		else
			response = {
				success: false,
				code: 200,
				status: "bad",
				message: "Shucks, username or password incorrect."
			}
			response.to_json
		end
  	end

  	post '/register' do
		puts "hitting register route"

		user = User.find_by username: @payload[:username]

		if not user
			user = User.new
			user.username = @payload[:username]
			user.password = @payload[:password]
			user.save

			session[:logged_in] = true
			session[:username] = user.username

			session[:message] = {
				success: true,
				code: 201,
				status: "good",
				message: "#{user.username} successfully created and loggin in.",
				username: user.username
			}

			response.to_json

		else
			session[:message] = {
				success: true,
				code: 200,
				status: "bad",
				message: "Sorry, username #{params[:username]} is taken."
			}

			response.to_json
		end
	end

end

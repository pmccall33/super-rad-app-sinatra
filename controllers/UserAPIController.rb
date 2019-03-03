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
  		"you have reached the test post route here"
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

			admin_message = ""

			if user.is_admin 
				session[:is_admin] = true 
				admin_message = "administrator: "
			end

			response = {
				success: true,
				code: 200,
				status: "good",
				message: "Logged in as #{admin_message}#{user.username}",
				username: user.username,
				userId: user.id,
				is_admin: user.is_admin 
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
			session[:is_admin] = user.is_admin

			response = {
				success: true,
				code: 201,
				status: "good",
				message: "#{user.username} successfully created and loggin in.",
				username: user.username,
				userId: user.id,
				is_admin: user.is_admin
			}

			response.to_json

		else

			response = {
				success: true,
				code: 200,
				status: "bad",
				message: "Sorry, username #{params[:username]} is taken."
			}

			response.to_json
		end
	end

	get '/logout' do
    	
	    # puts "#{session[:username]} session[:username] here"
	    # checking for session in postman is giving some issues but it is hitting the route
	    username = session[:username]

	    session.destroy 

	    response = {
	      success: true,
	      code: 200,
	      status: "good",
	      message: "#{username} is logged out."
	    }

	    response.to_json

	end
end

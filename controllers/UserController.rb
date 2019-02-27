class UserController < ApplicationController

	get '/test' do
		"User controller hooked up."
	end

	get '/home' do
		"Home Page"
		erb :home_index
	end

	get '/login' do
		"Home/Login route at Usercontroller"
		erb :login
	end

	get '/register' do
		erb :register
	end

	post '/register' do
		puts "hitting register route"
		
		user = User.find_by username: params[:username]

		if not user
			user = User.new
			user.username = params[:username]
			user.password = params[:password]
			user.save

			session[:logged_in] = true
			session[:username] = user.username

			session[:message] = {
				success: true,
				status: 'good',
				message: '#{user.username} successfully created and loggin in.'
			}

			redirect '/user/home'

		else
			session[:message] = {
				success: true,
				status: 'bad',
				message: 'Sorry, username #{params[:username]} is taken.'
			}

			redirect '/user/register'
		end

	end
end











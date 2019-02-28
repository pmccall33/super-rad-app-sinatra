class AdminController < ApplicationController 

	before ['/register'] do 
		if not (session[:logged_in] and session[:is_admin])
			session[:message] = "You must be logged in as an administrator to do that!"
			redirect '/admin/login'
		end
	end

	get "/register" do 
		erb :admin_register 
	end

	post '/register' do 

		extant_user = User.find_by username: params[:username]

		if not extant_user 
			session[:message] = "No such user is in the database"
			redirect 'admin/register'
		else 
			extant_user.is_admin = true 
			extant_user.save 
			session[:message] = "Gave #{extant_user.username} administrator access"
			redirect '/admin/register' 
		end

	end

end
class AdminController < ApplicationController	

	before ['/register'] do 
		if not (session[:logged_in] and session[:is_admin])
			session[:message] = "You must be logged in as an administrator to do that!"
			redirect '/admin/login'
		end
	end


	get '/' do 
		redirect '/'
	end


	get "/login" do 
		erb :admin_login
	end


	get "/register" do 
		erb :admin_register 
	end


	get "/logout" do 
		session.destroy 
		session[:message] = "Logged out"
		redirect '/'
	end


	post '/login' do 
		
		admin = User.find_by username: params[:username]

		pw = params[:password]

		# if not (admin and admin.authenticate(pw) and admin.is_admin)
		if not (admin and admin.password == pw and admin.is_admin)
			session[:message] = "Failed to log in as administrator"
			redirect '/admin/login'
		else 
			session.destroy 
			session[:logged_in] = true 
			session[:username] = params[:username]
			session[:is_admin] = true 
			session[:message] = "Logged in as administrator #{admin.username}"
			
			redirect '/image/new' 		
		end
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
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
end
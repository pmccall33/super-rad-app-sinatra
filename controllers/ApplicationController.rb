class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# firnd templates
	set :views, File.expand_path('../../views', __FILE__)

	# find static assets
	set :public_dir, File.expand_path('../../public', __FILE__)


	get '/' do
		"reached ApplicationController, supersweet"

		erb :home_index
	end

	get '/test' do	
		"reached test route"
		binding.pry
	end
end
class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	Dotenv.load

	# enable :sessions
		secret = ENV['SESSION_SECRET']

		use Rack::Session::Cookie, :key => 'rack.session',
                            :path => '/',
                            :secret => secret
    
    # middleware here
    use Rack::MethodOverride
  	set :method_override, true

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
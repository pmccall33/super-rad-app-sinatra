require 'sinatra/base'

# require controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/UserPathStepController'


#models
require './models/UserModel'
require './models/UserPathStepModel'

# specify routes
map '/' do
  run ApplicationController
end

map '/user' do
 	run UserController
end

map '/user_path' do
	run UserPathStepController
end
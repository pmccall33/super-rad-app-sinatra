require 'sinatra/base'

# require controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/UserAPIController'
require './controllers/UserPathStepController'


#models
require './models/UserModel'
require './models/UserPathStepModel'
require './models/ImageModel'

# specify routes
map '/' do
  run ApplicationController
end

map '/user' do
 	run UserController
end

map '/api/v1/user' do
  run UserAPIController
end

map '/user_path' do
	run UserPathStepController
end

map '/admin' do 
	run AdminController 
end
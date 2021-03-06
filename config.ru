require 'sinatra/base'

# require controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/UserAPIController'
require './controllers/UserPathStepController'
require './controllers/UserPathStepAPIController'
require './controllers/ImageController'
require './controllers/ImageAPIController'
require './controllers/AdminController'
require './controllers/AdminAPIController'

#models
require './models/UserModel'
require './models/UserPathStepModel'
require './models/ImageModel'
require './models/TagModel'


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

map ('/image') {
	run ImageController
}

map ('/api/v1/image') do
	run ImageAPIController
end

# map '/user_path' do
# 	run UserPathStepController
# end

map ('/api/v1/user_path_step') do
	run UserPathStepAPIController
end

map ('/admin') do
	run AdminController
end

map ('/api/v1/admin') do
	run AdminAPIController
end




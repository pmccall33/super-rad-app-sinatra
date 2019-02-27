require 'sinatra/base'

# require controllers
require './controllers/ApplicationController'
require './controllers/UserController'


#models
require './models/UserModel'


# specify routes
map '/' do
  run ApplicationController
end

map '/user' do
  run UserController
end
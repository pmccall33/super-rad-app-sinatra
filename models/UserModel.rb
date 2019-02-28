class User < ActiveRecord::Base
  has_secure_password
  has_many :user_path_steps
end
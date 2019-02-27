# README.md for Super - Rad

# Models

## User Model

### has_one :user_path_steps
### has_many :saved_user_paths
### id SERIAL PRIMARY KEY	
### username VARCHAR(255)
### saved_user_path INTEGER REFERENCES user_path_steps(id)
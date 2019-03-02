DROP DATABASE IF EXISTS super_rad_app_db;
CREATE DATABASE super_rad_app_db;

\c super_rad_app_db

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(32),
  password_digest VARCHAR(60),
  is_admin BOOLEAN NOT NULL DEFAULT FALSE 
);

CREATE TABLE images(
	id SERIAL PRIMARY KEY,
	image_url TEXT
);

CREATE TABLE tags(
	id SERIAL PRIMARY KEY,
	image_id INTEGER REFERENCES images(id) ,
	tag VARCHAR(32)
);

CREATE TABLE user_path_steps(
	id SERIAL PRIMARY KEY,
	user_id SERIAL REFERENCES users(id),
	image_id INTEGER REFERENCES images(id),
	path_id INTEGER,
	previous_step INTEGER
);

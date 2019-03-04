# Image Tagger 
### 'Helper app' for super rad 

Front-end repo: https://github.com/dakotahducharme/super-rad-react

API serving up images for the app [super rad](https://super-rad-react.herokuapp.com/) 

Back-end server to 'super rad', but also a fullstack app that stores images and tags in a SQL database. 

## User Story 
1. Users view an image randomly chosen from the database, along with a prompt selected from a hard-coded bank 
2. User may skip to the next image, or enter a one-word tag in response to the prompt 
3. In either case, another random image from the database is displayed 
4. Users with admin access privileges may add images to the database  

## API Documentation 

How to serve up images from our database, using this backend as a source: 

### GET Route:  /api/v1/image/:id 

GET: `/api/v1/image/:id`
Attempts to find related images based on the :id parameter passed into the get route. If related images are found, will return an array of up to four images with related tags in the database. If images are found, you will receive a response in JSON in the following form: 


`response = {
	success: true,
	code: 200,
	status: "good",
	message: "returning array of selected images",
	image_arr: <ARRAY OF IMAGES>
}`

If the response is received, but images are not found, the response will be in JSON of the following form: 

`response = {
	success: false,
	code: 200,
	status: "bad",
	message: <VARIES>,
}` 

### GET Route: /api/v1/image/random/:num

GET: `/api/v1/image/random/:num`
Returns an array of random images of the :num parameter specified, drawn from the database. The response will be in JSON of the following form: 

`response = {
	success: true,
	code: 200,
	status: "good",
	message: "get rndom image route success, returning array of images",
	rand_image_arr: @rand_image_arr
}` 

## (P)SQL MIGRATIONS
`DROP DATABASE IF EXISTS super_rad_app_db;
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
	image_id INTEGER REFERENCES images(id),
	image_tag VARCHAR(32)
);
CREATE TABLE user_path_steps(
	id SERIAL PRIMARY KEY,
	user_id SERIAL REFERENCES users(id),
	image_id INTEGER REFERENCES images(id),
	path_id INTEGER,
	previous_step INTEGER
);
`
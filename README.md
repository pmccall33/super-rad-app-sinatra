# super rad 
- Front-end repo: https://github.com/dakotahducharme/super-rad-react

## super rad API/Back
- API serving up relational images for the super rad app: https://super-rad-react.herokuapp.com/ 
- Backend server to main super rad app,
- also a fullstack app that contains the tagger/seed mini-app which
stores images and tags in a SQL database.

#### Upcoming Features: 
- finish out 'version control' with user_path to allow user to create their own tree of their story's path.
- THEN: Update and map the image data onto a Data Structure \(somethng Djiksra-esque?\) with edge weights indicating relationships between images, tag descriptors, and a user_path as distance. 
- Allow a user to visualize their local Data Structure for their path version in real time.
- Show visualization of the Global App State-o-the-Struct and allow for delta time animations of relational changes.


## Image Tagger 
#### 'Helper app' for super rad 
 - A mini app to crowd-source paired keywords with randomized images in order to seed the database to provide useful relational data to main super rad app where users can click through a visual story.

#### User Story for Image-Tagger
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
	code: 400,
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
DROP DATABASE IF EXISTS super_rad_app_db;
CREATE DATABASE super_rad_app_db;

\c super_rad_app_db

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(32),
  password_digest VARCHAR(60)
);
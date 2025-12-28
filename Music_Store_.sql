## Creating Database named as 'music_store'
CREATE DATABASE music_store;
USE music_store;

## CREATE TABLES
## Base Table

CREATE TABLE IF NOT EXISTS media_type(
media_type_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS genre( 
genre_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS artist( 
artist_id INT AUTO_INCREMENT PRIMARY KEY,
name varchar(100)
);

## REFERENCING TABLES
CREATE TABLE IF NOT EXISTS album(
album_id INT AUTO_INCREMENT PRIMARY KEY,
title varchar(100),
artist_id INT,
FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE IF NOT EXISTS track(
track_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
album_id INT,
media_type_id INT,
genre_id INT,
composer VARCHAR(100),
milliseconds INT,
bytes INT,
unit_price INT,
FOREIGN KEY (album_id) REFERENCES album(album_id),
FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id),
FOREIGN KEY (genre_id) REFERENCES genre(genre_id));

## CORE BUSINESS TABLES 
CREATE TABLE IF NOT EXISTS employee(
employee_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
title VARCHAR(100),
reports_to VARCHAR(100),
levels VARCHAR(100),
birthdate DATE,
hire_date DATE,
address VARCHAR(100),
city VARCHAR(100),
state VARCHAR(100),
country VARCHAR(100),
postal_code VARCHAR(100),
phone VARCHAR(100),
fax VARCHAR(100),
email VARCHAR(100));

CREATE TABLE IF NOT EXISTS customer(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
company VARCHAR(100),
address VARCHAR(100),
city VARCHAR(100),
state VARCHAR(100),
country VARCHAR(100),
postal_code VARCHAR(100),
phone VARCHAR(100),
fax VARCHAR(100),
email VARCHAR(100),
support_rep_id INT,
FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id));

CREATE TABLE IF NOT EXISTS playlist(
playlist_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100)
);

## TRANSACTIONAL AND JUNCTION TABLES
-- invoice, invoice_line, playlist_track

CREATE TABLE IF NOT EXISTS invoice(
invoice_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
invoice_date DATE,
billing_address VARCHAR(100),
billing_city VARCHAR(100),
billing_state VARCHAR(100),
billing_country VARCHAR(100),
billing_postal_code VARCHAR(100),
total DECIMAL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id) 
);

CREATE TABLE IF NOT EXISTS invoice_line(
invoice_line_id INT AUTO_INCREMENT PRIMARY KEY,
invoice_id INT,
track_id INT,
unit_price VARCHAR(100),
quantity VARCHAR(100),
FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
FOREIGN KEY (track_id) REFERENCES track(track_id)
);

CREATE TABLE IF NOT EXISTS playlist_track(
playlist_id INT,
track_id INT,
PRIMARY KEY (playlist_id, track_id),
FOREIGN KEY (playlist_id) REFERENCES playlist (playlist_id),
FOREIGN KEY (TRACK_ID) REFERENCES track(TRACK_ID)
);

-- This is the SQL script that will help to create the necessary tables concerning a movie theater

-- First we need to create a few tables
-- Customer table -> contains no foreign keys
-- Ticket table -> contains foreign keys from showing and customer
-- Showing table -> contains foreign key from movie
-- Movie table -> contains no foreign keys
-- Actor table -> contains no foreign keys
-- Movie Actor join table -> contains foreign keys from movie and actor

-- First I will create all of the tables that have no foreign keys (dependencies)
-- Then I will create the tables that use the created tables


CREATE TABLE IF NOT EXISTS customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	is_member BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS movie (
	movie_id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	duration INTEGER,
	rating VARCHAR(10),
	score INTEGER,
	description VARCHAR
);

CREATE TABLE IF NOT EXISTS actor (
	actor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	actor_age INTEGER
);

-- now that we have our first three tables set up, time to make our movie_actor, showing, and ticket tables
CREATE TABLE IF NOT EXISTS movie_actor (
	movie_id INTEGER NOT NULL,
	FOREIGN KEY (movie_id) REFERENCES movie (movie_id),
	actor_id INTEGER NOT NULL,
	FOREIGN KEY (actor_id) REFERENCES actor (actor_id)
);


CREATE TABLE IF NOT EXISTS showing (
	showing_id SERIAL PRIMARY KEY,
	movie_id INTEGER NOT NULL,
	FOREIGN KEY (movie_id) REFERENCES movie (movie_id),
	showing_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS ticket (
	ticket_id SERIAL PRIMARY KEY,
	seat_number INTEGER,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
	showing_id INTEGER NOT NULL,
	FOREIGN KEY (showing_id) REFERENCES showing (showing_id)	
);


-- WITH THIS OUR BASIC SETUP OF TABLES IS COMPLETED.

-- practicing altering and dropping from tables.
-- trying to add a column to customer called cash and then drop it afterwards

-- adding a column called cash
ALTER TABLE customer
ADD COLUMN IF NOT EXISTS cash INTEGER;

SELECT *
FROM customer;

-- renaming the cash column to to_be_deleted
ALTER TABLE customer
RENAME COLUMN cash TO to_be_deleted;

-- deleting the renamed column
ALTER TABLE customer 
DROP COLUMN IF EXISTS to_be_deleted;

SELECT *
FROM customer;

-- And it is deleted!

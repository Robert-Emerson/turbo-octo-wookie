CREATE TABLE IF NOT EXISTS recipes
	(recipe_id int(11) AUTO_INCREMENT,
	name varchar(30),
	PRIMARY KEY (recipe_id));

CREATE TABLE IF NOT EXISTS users
	(username varchar(30),
	password varchar(255),
	email varchar(255),
	PRIMARY KEY (username));
	
CREATE TABLE IF NOT EXISTS ingredients
	(ingredient_id int AUTO_INCREMENT,
	ingredient_name varchar(30),
	PRIMARY KEY (ingredient_id));
	
CREATE TABLE IF NOT EXISTS recipe_types
	(recipe_type varchar(20),
	PRIMARY KEY(recipe_type));

CREATE TABLE IF NOT EXISTS recipe_is
	(recipe_id int(11),
	recipe_type varchar(20),
	PRIMARY KEY(recipe_id, recipe_type),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id),
	FOREIGN KEY(recipe_type) REFERENCES recipe_types(recipe_type));
	
CREATE TABLE IF NOT EXISTS instructions
	(instruction_id int(11),
	recipe_id int,
	instruction_text varchar(500),
	PRIMARY KEY (instruction_id, recipe_id),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id));
	
CREATE TABLE IF NOT EXISTS ingredients_used
	(recipe_id int AUTO_INCREMENT,
	ingredient_id int,
	measurement varchar(20),
	PRIMARY KEY(recipe_id, ingredient_id),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id),
	FOREIGN KEY(ingredient_id) REFERENCES ingredients(ingredient_id));
	
CREATE TABLE IF NOT EXISTS recipe_pictures
	(recipe_id int AUTO_INCREMENT,
	picture_url varchar(100),
	PRIMARY KEY(recipe_id, picture_url),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id));
	
CREATE TABLE IF NOT EXISTS comments
	(username varchar(30),
	recipe_id int,
	posttime timestamp,
	comment_text varchar(1000),
	rating int,
	PRIMARY KEY(username, recipe_id),
	FOREIGN KEY(username) REFERENCES users(username),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id),
	check (rating > -1 AND rating < 6 ));
	
CREATE TABLE IF NOT EXISTS favorites
	(username varchar(30),
	recipe_id int,
	PRIMARY KEY(username, recipe_id),
	FOREIGN KEY(username) REFERENCES users(username),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id));
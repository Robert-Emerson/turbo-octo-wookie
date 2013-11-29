CREATE TABLE IF NOT EXISTS recipes
	(recipe_id int(11) AUTO_INCREMENT,
	name varchar(30),
	PRIMARY KEY (recipe_id));

CREATE TABLE IF NOT EXISTS users
	(username varchar(30),
	password varchar(255),
	email varchar(255),
	salt varchar(255),
	PRIMARY KEY (username));
	
CREATE TABLE IF NOT EXISTS ingredients
	(ingredient_name varchar(30),
	ingredient_description varchar (200),
	PRIMARY KEY (ingredient_name));
	
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
	(recipe_id int,
	instruction_text varchar(4000),
	PRIMARY KEY (recipe_id)) engine=MyISAM;

ALTER TABLE `instructions` ADD FULLTEXT(`instruction_text`);
	
CREATE TABLE IF NOT EXISTS ingredients_used
	(recipe_id int,
	ingredient_name varchar(30),
	measurement varchar(20),
	PRIMARY KEY(recipe_id, ingredient_name),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id),
	FOREIGN KEY(ingredient_name) REFERENCES ingredients(ingredient_name));
	
CREATE TABLE IF NOT EXISTS recipe_pictures
	(recipe_id int,
	picture_url varchar(100),
	PRIMARY KEY(recipe_id, picture_url),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id));
	
CREATE TABLE IF NOT EXISTS comments
	(username varchar(30),
	recipe_id int,
	posttime timestamp,
	comment_text varchar(1000),
	rating int DEFAULT '-1',
	PRIMARY KEY(username, recipe_id, posttime),
	FOREIGN KEY(username) REFERENCES users(username),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id),
	check (rating > -1 AND rating < 6 ));
	
CREATE TABLE IF NOT EXISTS favorites
	(username varchar(30),
	recipe_id int,
	PRIMARY KEY(username, recipe_id),
	FOREIGN KEY(username) REFERENCES users(username),
	FOREIGN KEY(recipe_id) REFERENCES recipes(recipe_id));

GRANT SELECT ON users TO 'cs4750roe2pja'@'%';
GRANT SELECT ON comments TO 'cs4750roe2pja'@'%';
GRANT SELECT ON recipes TO 'cs4750roe2pja'@'%';
GRANT SELECT ON favorites TO 'cs4750roe2pja'@'%';

GRANT INSERT ON users TO 'cs4750roe2pjb'@'%';

GRANT SELECT ON recipe_types TO 'cs4750roe2pjc'@'%';
GRANT SELECT ON recipe_is TO 'cs4750roe2pjc'@'%';
GRANT SELECT ON recipes TO 'cs4750roe2pjc'@'%';
GRANT SELECT ON instructions TO 'cs4750roe2pjc'@'%';
GRANT SELECT ON ingredients TO 'cs4750roe2pjc'@'%';
GRANT SELECT ON ingredients_used TO 'cs4750roe2pjc'@'%';
GRANT SELECT ON recipe_pictures TO 'cs4750roe2pjc'@'%';

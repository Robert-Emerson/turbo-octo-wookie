--Must change delimiter in phpMyAdmin to $$ before executing

DROP TRIGGER IF EXISTS recipe_added$$
CREATE TRIGGER recipe_added 
AFTER INSERT ON cs4750roe2pj.recipes 
FOR EACH ROW 
BEGIN 
INSERT INTO instructions (instruction_id, recipe_id) values (DEFAULT, NEW.recipe_id); 
END$$ 

DROP PROCEDURE IF EXISTS cs4750roe2pj.register_user$$
CREATE PROCEDURE cs4750roe2pj.register_user (
    IN username varchar(30),
    IN password varchar(255),
    IN email varchar(255),
    IN salt varchar(255))
BEGIN
    INSERT INTO users (username, password, email, salt) VALUES (username, password, email, salt);
END$$

GRANT EXECUTE ON PROCEDURE cs4750roe2pj.register_user TO 'cs4750roe2pja'@'%'$$

DROP PROCEDURE IF EXISTS cs4750roe2pj.login_user$$
CREATE PROCEDURE cs4750roe2pj.login_user (
    IN userIn varchar(30))
BEGIN
    SELECT password, salt FROM users WHERE username = userIn LIMIT 1;
END$$

GRANT EXECUTE ON PROCEDURE cs4750roe2pj.login_user TO 'cs4750roe2pjb'@'%'$$
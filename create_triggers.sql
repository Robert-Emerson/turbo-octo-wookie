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
    SELECT * FROM users WHERE username = userIn LIMIT 1;
END$$

GRANT EXECUTE ON PROCEDURE cs4750roe2pj.login_user TO 'cs4750roe2pjb'@'%'$$

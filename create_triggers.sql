--Must change delimiter in phpMyAdmin to $$ before executing

CREATE TRIGGER recipe_added 
AFTER INSERT ON recipes 
FOR EACH ROW 
BEGIN 
INSERT INTO instructions (instruction_id, recipe_id) values (DEFAULT, NEW.recipe_id); 
END;$$ 
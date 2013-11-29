--User creation done in web_methods.py so data can be properly hashed and salted

INSERT INTO recipe_types (recipe_type) VALUES ('Bread'), ('Breakfast'), ('Appetizers'), ('Dessert'), ('Main Dishes'), ('Side Dishes'), ('Gluten-Free');

SET @next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='recipes');
INSERT INTO recipes (name) VALUES ('No-Knead Bread');
INSERT INTO instructions (recipe_id, instruction_text) VALUES (@next_id, '1. In a large bowl combine flour, yeast and salt. Add 1 5/8 cups water, and stir until blended; dough will be shaggy and sticky. Cover bowl with plastic wrap. Let dough rest at least 12 hours, preferably about 18, at warm room temperature, about 70 degrees.
2. Dough is ready when its surface is dotted with bubbles. Lightly flour a work surface and place dough on it; sprinkle it with a little more flour and fold it over on itself once or twice. Cover loosely with plastic wrap and let rest about 15 minutes.
3. Using just enough flour to keep dough from sticking to work surface or to your fingers, gently and quickly shape dough into a ball. Generously coat a cotton towel (not terry cloth) with flour, wheat bran or cornmeal; put dough seam side down on towel and dust with more flour, bran or cornmeal. Cover with another cotton towel and let rise for about 2 hours. When it is ready, dough will be more than double in size and will not readily spring back when poked with a finger.
4. At least a half-hour before dough is ready, heat oven to 450F. Put a 6- to 8-quart heavy covered pot (cast iron, enamel, Pyrex or ceramic) in oven as it heats. When dough is ready, carefully remove pot from oven. Slide your hand under towel and turn dough over into pot, seam side up; it may look like a mess, but that is O.K. Shake pan once or twice if dough is unevenly distributed; it will straighten out as it bakes. Cover with lid and bake 30 minutes, then remove lid and bake another 15 to 30 minutes, until loaf is beautifully browned. Cool on a rack.
Recipe and images from http://www.smittenkitchen.com');

INSERT INTO ingredients (ingredient_name) VALUES ('bread flour'), ('instant yeast'), ('salt'), ('cornmeal');
INSERT INTO ingredients_used (recipe_id, ingredient_name, measurement) VALUES (@next_id, 'bread flour', '3 cups'), (@next_id, 'instant yeast', '1/4 teaspoons'), (@next_id, 'salt', '1 and 1/4 teaspoons'), (@next_id, 'cornmeal', 'dusting of');
INSERT INTO recipe_is (recipe_id, recipe_type) VALUES (@next_id, 'Bread');
INSERT INTO recipe_pictures (recipe_id, picture_url) VALUES (@next_id, 'http://static.flickr.com/116/296828116_f6b93e05b3.jpg'), (@next_id, 'http://static.flickr.com/110/296828115_9fae594a40.jpg');
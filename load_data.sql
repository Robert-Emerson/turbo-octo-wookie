INSERT INTO recipe_types (recipe_type) VALUES ('Bread'), ('Breakfast'), ('Appetizers'), ('Dessert'), ('Main Dishes'), ('Side Dishes'), ('Gluten-Free');

SET @next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='cs4750roe2pj' AND TABLE_NAME='recipes');
INSERT INTO cs4750roe2pj.recipes (name) VALUES ('No-Knead Bread');
INSERT INTO cs4750roe2pj.instructions (recipe_id, instruction_text) VALUES (@next_id, '1. In a large bowl combine flour, yeast and salt. Add 1 5/8 cups water, and stir until blended; dough will be shaggy and sticky. Cover bowl with plastic wrap. Let dough rest at least 12 hours, preferably about 18, at warm room temperature, about 70 degrees.
2. Dough is ready when its surface is dotted with bubbles. Lightly flour a work surface and place dough on it; sprinkle it with a little more flour and fold it over on itself once or twice. Cover loosely with plastic wrap and let rest about 15 minutes.
3. Using just enough flour to keep dough from sticking to work surface or to your fingers, gently and quickly shape dough into a ball. Generously coat a cotton towel (not terry cloth) with flour, wheat bran or cornmeal; put dough seam side down on towel and dust with more flour, bran or cornmeal. Cover with another cotton towel and let rise for about 2 hours. When it is ready, dough will be more than double in size and will not readily spring back when poked with a finger.
4. At least a half-hour before dough is ready, heat oven to 450F. Put a 6- to 8-quart heavy covered pot (cast iron, enamel, Pyrex or ceramic) in oven as it heats. When dough is ready, carefully remove pot from oven. Slide your hand under towel and turn dough over into pot, seam side up; it may look like a mess, but that is O.K. Shake pan once or twice if dough is unevenly distributed; it will straighten out as it bakes. Cover with lid and bake 30 minutes, then remove lid and bake another 15 to 30 minutes, until loaf is beautifully browned. Cool on a rack.
Recipe and images from http://www.smittenkitchen.com');

INSERT INTO cs4750roe2pj.ingredients (ingredient_name, ingredient_description) VALUES ('bread flour', 'A high protein flour milled from hard winter wheat. Contains more gluten than regular all-purpose flour, helping baked goods to hold their rise.'), ('yeast', 'Microscopic single-celled fungi that metabolize sugar into energy, producing carbon dioxide and alcohol as by-products.'), ('salt', 'Sodium chloride (NaCl). A simple, inorganic molecule used to enhance and modify taste, in addition to being the only natural source of one of our basic tastes.'), ('cornmeal', 'Dry-ground corn, typically about 0.2mm in diameter. Often used to provide flavor and subtle grainy texture.');
INSERT INTO cs4750roe2pj.ingredients_used (recipe_id, ingredient_name, measurement) VALUES (@next_id, 'bread flour', '3 cups'), (@next_id, 'yeast', '1/4 teaspoons'), (@next_id, 'salt', '1 and 1/4 teaspoons'), (@next_id, 'cornmeal', 'dusting of');
INSERT INTO cs4750roe2pj.recipe_is (recipe_id, recipe_type) VALUES (@next_id, 'Bread');
INSERT INTO cs4750roe2pj.recipe_pictures (recipe_id, picture_url) VALUES (@next_id, 'http://static.flickr.com/116/296828116_f6b93e05b3.jpg'), (@next_id, 'http://static.flickr.com/110/296828115_9fae594a40.jpg');

SET @next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='cs4750roe2pj' AND TABLE_NAME='recipes');
INSERT INTO cs4750roe2pj.recipes (name) VALUES ('Cranberry Lemon Scones');
INSERT INTO cs4750roe2pj.instructions (recipe_id, instruction_text) VALUES (@next_id, '1. Preheat oven to 400°F. and line a large baking sheet with parchment paper.
2. With a vegetable peeler remove the zest from lemons and chop fine, reserving lemons for another use.
3. In a food processor pulse flour, 1/2 cup sugar, baking powder, salt, butter and zest until mixture resembles coarse meal and transfer to a large bowl.
4. In a small bowl toss together fresh cranberries and an extra 3 tablespoons sugar and stir into flour mixture. If using dried fruit, add to flour mixture.
5. In another small bowl lightly beat egg and yolk and stir in cream. Add egg mixture to flour mixture and stir until just combined.
6. On a well-floured surface with floured hands pat dough into a 1-inch-thick round (about 8 inches in diameter) and with a 2-inch round cutter or rim of a glass dipped in flour cut out as many rounds as possible, rerolling scraps as necessary. Arrange rounds about 1 inch apart on baking sheet and bake in middle of oven 15 to 20 minutes, or until pale golden.
7. Serve scones warm with creme fraiche or whipped cream. Scones keep, individually wrapped in plastic wrap and foil, chilled, 1 day or frozen 1 week.
Recipe and images from http://www.smittenkitchen.com');

INSERT INTO cs4750roe2pj.ingredients (ingredient_name, ingredient_description) VALUES ('lemon zest', ''), ('all-purpose flour', ''), ('sugar', ''), ('baking powder', ''), ('unsalted butter', ''), ('cranberries', ''), ('egg(s)', ''), ('egg yolk', ''), ('heavy cream', '');
INSERT INTO cs4750roe2pj.ingredients_used (recipe_id, ingredient_name, measurement) VALUES (@next_id, 'lemon zest', '1 1/2 tablespoons'), (@next_id, 'all-purpose flour', '2 1/2 cups'), (@next_id, 'sugar', '1/2 cup'), (@next_id, 'salt', '1/2 teaspoon'), (@next_id, 'unsalted butter', '6 tablespoons'), (@next_id, 'cranberries', '1 1/4 cups'), (@next_id, 'egg(s)', '1 large'), (@next_id, 'egg yolk', '1 large'), (@next_id, 'heavy cream', '1 cup');
INSERT INTO cs4750roe2pj.recipe_is (recipe_id, recipe_type) VALUES (@next_id, 'Bread'), (@next_id, 'Breakfast');
INSERT INTO cs4750roe2pj.recipe_pictures (recipe_id, picture_url) VALUES (@next_id, 'http://farm4.static.flickr.com/3180/3033305250_42d745d78a.jpg'), (@next_id, 'http://farm4.static.flickr.com/3296/3033318882_757905cea8.jpg'), (@next_id, 'http://farm4.static.flickr.com/3212/3033321032_be4052dfa8.jpg');



SET @next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='cs4750roe2pj' AND TABLE_NAME='recipes');
INSERT INTO cs4750roe2pj.recipes (name) VALUES ('Raspberry Coconut Macaroons');
INSERT INTO cs4750roe2pj.instructions (recipe_id, instruction_text) VALUES (@next_id, '1. Preheat oven to 325°F. Line two large baking sheets with parchment paper.
2. In a food processor, blend the coconut for a minute. Add sugar, blend another minute. Add egg whites, salt and almond extract and blend for another minute. Add raspberries and pulse machine on and off in short bursts until they are largely, but not fully, broken down. (I counted 13 pulses. I might have been a little obsessive, what with the counting.) Some visible flecks of raspberry here and there are great. When you open the machine, you’ll see some parts of the batter that are still fully white while others are fully pink. Resist stirring them together.
3. With a tablespoon measure or cookie scoop (I used a #70), scoop batter into 1-inch mounds. You can arrange the cookies fairly close together as they don’t spread, just puff a bit. Scooping a little of the pink batter and a little of the white batter together makes them look extra marble-y and pretty.
4. Bake cookies for 25 to 30 minutes, until they look a little toasted on top. Let them rest on the tray for 10 minutes after baking (or you can let them fully cool in place, if you’re not in a rush to use the tray again), as they’ll be hard to move right out of the oven. They’ll firm up as they cool, but still remain softer and less dry inside than traditional macaroons
Recipe and images from http://www.smittenkitchen.com');

INSERT INTO cs4750roe2pj.ingredients (ingredient_name, ingredient_description) VALUES ('sweetened, flaked coconut', ''), ('egg whites', ''), ('almond extract', ''), ('raspberries', '');
INSERT INTO cs4750roe2pj.ingredients_used (recipe_id, ingredient_name, measurement) VALUES (@next_id, 'sweetened, flaked coconut', '14 ounces'), (@next_id, 'sugar', '2/3 cups'), (@next_id, 'egg whites', '3 large'), (@next_id, 'salt', '1/4 teaspoon'), (@next_id, 'almond extract', '1/2 teaspoon'), (@next_id, 'raspberries', '1 1/4 cups'), (@next_id, 'egg(s)', '1 large'), (@next_id, 'egg yolk', '1 large'), (@next_id, 'heavy cream', '1 cup');
INSERT INTO cs4750roe2pj.recipe_is (recipe_id, recipe_type) VALUES (@next_id, 'Dessert'), (@next_id, 'Gluten-Free');



SET @next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='cs4750roe2pj' AND TABLE_NAME='recipes');
INSERT INTO cs4750roe2pj.recipes (name) VALUES ('My Favorite Brownies');
INSERT INTO cs4750roe2pj.instructions (recipe_id, instruction_text) VALUES (@next_id, '1. Heat oven to 350°F. Line an 8×8-inch square baking pan with parchment, extending it up two sides, or foil. Butter the parchment or foil or spray it with a nonstick cooking spray.
2. Roughly chop the chocolate then, in a medium heatproof bowl over gently simmering water, melt chocolate and butter together until only a couple unmelted bits remain. Off the heat, stir until smooth and fully melted. You can also do this in the microwave in 30-second bursts, stirring between each. Whisk in sugar, then eggs, one at a time, then vanilla and salt. Stir in flour with a spoon or flexible spatula and scrape batter into prepared pan, spread until even. Bake for 25 to 30 minutes, or until a toothpick inserted into the center comes out batter-free.
3. Let cool and cut into desired size and shape. If desired, dust the brownies with powdered sugar before serving.
If wanted, you can substitute 1/4 cup coconut flour for the 2/3 cup all-purpose flour to make this recipe gluten free.
Recipe and images from http://www.smittenkitchen.com');

INSERT INTO cs4750roe2pj.ingredients (ingredient_name, ingredient_description) VALUES ('unsweetened chocolate', ''), ('vanilla extract', '');
INSERT INTO cs4750roe2pj.ingredients_used (recipe_id, ingredient_name, measurement) VALUES (@next_id, 'unsweetened chocolate', '3 ounces'), (@next_id, 'sugar', '1 1/3 cups'), (@next_id, 'egg(s)', '2 large'), (@next_id, 'salt', '1/4 teaspoon'), (@next_id, 'vanilla extract', '1 teaspoon'), (@next_id, 'all-purpose flour', '2/3 cups'), (@next_id, 'unsalted butter', '1 stick');
INSERT INTO cs4750roe2pj.recipe_is (recipe_id, recipe_type) VALUES (@next_id, 'Dessert'), (@next_id, 'Gluten-Free');
INSERT INTO cs4750roe2pj.recipe_pictures (recipe_id, picture_url) VALUES (@next_id, 'http://farm8.staticflickr.com/7107/7810496190_9c04c5f966.jpg');



SET @next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='cs4750roe2pj' AND TABLE_NAME='recipes');
INSERT INTO cs4750roe2pj.recipes (name) VALUES ('Potato Pizza');
INSERT INTO cs4750roe2pj.instructions (recipe_id, instruction_text) VALUES (@next_id, '1. Combine flour, 1/2 teaspoon salt, sugar, and yeast in the bowl of an electric mixer, and slowly add 1 cup cold water. Mix on low speed until ingredients begin to combine. Switch to a dough hook and continue to mix for about 10 minutes until the dough is smooth and elastic and cleanly pulls away from the sides of the mixing bowl.
2. Place dough in an oiled bowl, and allow to rest for 2 to 4 hours until it has doubled in size. Split the dough into halves, and form each into a log. Place each log on a generously floured surface, and allow it to rest until the formed dough doubles in size again, at least 1 hour.
3. While the dough rises for the second time, repare the potato topping. Slice potatoes very thin using a knife or a mandoline. Then soak them in several changes of ice water to remove excess starch and prevent discoloration. Drain slices in a colander, toss with 1/2 teaspoon salt, and set aside for 10 minutes. Drain any accumulated water. In a medium bowl, combine potatoes, onions, and 1 tablespoon olive oil, and set aside.
4. Preheat oven to 450 degrees. Prepare two rimmed baking sheets with vegetable oil. Divide dough in half. Place each piece on its own baking sheet. Using the palms of your hands, flatten dough out to the edges of the pan. Evenly spread potatoes over the surface of the dough up to the very edge, or about 1 inch from the edge if you desire a crust on your pizza. Season with remaining 1/2 teaspoon salt and remaining 3 tablespoons olive oil. Sprinkle with rosemary if using.
5. Bake potato pizza until it has shrunk away from the edges of a pan and the bottom is golden brown, about 20 minutes. Remove from oven, and allow to cool slightly; slice into pieces, and serve. Potato pizza is also delicious served at room temperature.
Fresh rosemary can be used as a garnish.
Recipe and images from http://www.smittenkitchen.com');

INSERT INTO cs4750roe2pj.ingredients (ingredient_name, ingredient_description) VALUES ('olive oil', ''), ('potato(es)', ''), ('onion(s)', '');
INSERT INTO cs4750roe2pj.ingredients_used (recipe_id, ingredient_name, measurement) VALUES (@next_id, 'all-purpose flour', '3 cups'), (@next_id, 'salt', '1 1/2 teaspoons'), (@next_id, 'sugar', '3/4 teaspoon'), (@next_id, 'yeast', '1 teaspoon'), (@next_id, 'potato(es)', '2 thinly sliced'), (@next_id, 'onion(s)', '1/2 diced'), (@next_id, 'olive oil', '4 tablespoons + a bit');
INSERT INTO cs4750roe2pj.recipe_is (recipe_id, recipe_type) VALUES (@next_id, 'Main Dishes');
INSERT INTO cs4750roe2pj.recipe_pictures (recipe_id, picture_url) VALUES (@next_id, 'http://farm4.static.flickr.com/3049/2550232260_a828451cca.jpg'), (@next_id, 'http://farm4.static.flickr.com/3107/2550240418_4580f2be05.jpg');
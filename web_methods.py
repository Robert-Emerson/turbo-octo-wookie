import hashlib
import pymysql
import uuid
import os

__author__ = 'robert'



def connect_db(user, password):
    db_connection = pymysql.connect(host="stardock.cs.virginia.edu", user=user, passwd=password, db="cs4750roe2pj")
    return db_connection


def close_db(db_connection):
    db_connection.close()


def authenticate_user(username, password):
    db = connect_db('cs4750roe2pjb', 'PASSOWRD')
    db_cursor = db.cursor()
    username = db.escape_string(username)
    args = [username]
    db_cursor.callproc("cs4750roe2pj.login_user", args)
    db.commit()
    result = db_cursor.fetchone()
    if not result:
        return False
    db_pass = result[1]
    db_salt = result[3]
    if password_hash(password + db_salt) == db_pass:
        db_cursor.close()
        db.close()
        return True
    return False


def user_create(username, password, email):
    salt = uuid.uuid1().hex
    password = password_hash(password + salt)
    db = connect_db('cs4750roe2pja', 'PASSWORD')
    db_cursor = db.cursor()

    username = db.escape_string(username)
    password = db.escape_string(password)
    email = db.escape_string(email)
    salt = db.escape_string(salt)
    args = [username, password, email, salt]
    retval = False
    try:
        db_cursor.callproc("cs4750roe2pj.register_user", args)
        db.commit()
        retval = True
    except Exception as e:
        """ User already in database"""
        print e.message
        pass
    finally:
        db_cursor.close()
        db.close()
        return retval


def get_categories():
    retval = []
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        db_cursor.execute("SELECT DISTINCT recipe_type FROM recipe_types;")
        db.commit()
        for val in db_cursor.fetchall():
            retval += val
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval


def get_recipes(name):
    retval = {}
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        name = db.escape_string(name)
        db_cursor.execute("SELECT recipe_id, name FROM recipes NATURAL JOIN recipe_is WHERE recipe_type = %s;", name)
        db.commit()
        retval[name] = []
        for val in db_cursor.fetchall():
            link = '/recipes/' + str(val[1]).replace(' ', '_') + '/' + str(val[0])
            retval[name].append((val[1], link))
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval


def load_recipe(recipe_id):
    recipe_id = str(recipe_id)
    ingredients = []
    instructions = []
    pictures = []
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        recipe_id = db.escape_string(recipe_id)
        db_cursor.execute("SELECT * FROM ingredients NATURAL JOIN ingredients_used NATURAL JOIN recipes WHERE recipe_id = %s;", recipe_id)
        db.commit()
        for val in db_cursor.fetchall():
            ingredients.append(val[3] + ' ' + val[1])  # Builds the ingredient
        db_cursor.execute("SELECT * FROM recipes NATURAL JOIN instructions WHERE recipe_id = %s;", recipe_id)
        db.commit()
        val = db_cursor.fetchone()
        instructions = str(val[2]).encode('utf-8').split('\r\n')
        db_cursor.execute("SELECT picture_url FROM recipes NATURAL JOIN recipe_pictures WHERE recipe_id = %s;", recipe_id)
        db.commit()
        for val in db_cursor.fetchall():
            pictures.append(val[0])  # add picture url here
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return (ingredients, instructions, pictures)

def load_comments(recipe_id):
    recipe_id = str(recipe_id)
    comments = []
    rating = 0.0
    rating_count = 0
    num_favorites = 0
    avg_rating = 0
    db = connect_db('cs4750roe2pja', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        recipe_id = db.escape_string(recipe_id)
        db_cursor.execute("SELECT username, comment_text, rating FROM users NATURAL JOIN comments NATURAL JOIN recipes WHERE recipe_id = %s ORDER BY posttime DESC;", recipe_id)
        db.commit()
        for val in db_cursor.fetchall():
            insert_val = [val[0],val[1]]
            comments.append(insert_val)
            if val[2] != -1:
                rating += val[2]
                rating_count += 1
        if rating_count > 0:
            avg_rating = rating / rating_count
        db_cursor.execute("SELECT COUNT(*) FROM favorites WHERE recipe_id = %s;", recipe_id)
        db.commit()
        val = db_cursor.fetchone()
        num_favorites = val[0]
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return (num_favorites,comments,recipe_id, avg_rating)

#TODO DIFFERENT DB USER
def insert_comment(username, recipe_id, comment_text, rating):
    recipe_id = str(recipe_id)
    comment_text = str(comment_text)
    rating = str(rating)
    username = str(username)
    db = connect_db('cs4750roe2pj', 'PASSOWRD')
    db_cursor = db.cursor()
    try:
        recipe_id = db.escape_string(recipe_id)
        username = db.escape_string(username)
        comment_text = db.escape_string(comment_text)
        rating = db.escape_string(rating)

        db_cursor.execute("INSERT INTO comments (username, recipe_id, comment_text, rating) VALUES (%s,%s,%s,%s);", (username, recipe_id, comment_text, rating))
        db.commit()
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()

#TODO different db user
def insert_favorite(username, recipe_id):
    recipe_id = str(recipe_id)
    username = str(username)
    db = connect_db('cs4750roe2pj', 'PASSWROD')
    db_cursor = db.cursor()
    try:
        recipe_id = db.escape_string(recipe_id)
        username = db.escape_string(username)

        db_cursor.execute("INSERT INTO favorites (username, recipe_id) VALUES (%s,%s);", (username, recipe_id))
        db.commit()
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()


def search_recipes(search_string):
    retval = {}
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        search_string = '%' + db.escape_string(search_string) + '%'
        db_cursor.execute("SELECT recipe_id, name FROM recipes  WHERE name LIKE %s;", search_string)
        db.commit()
        retval[search_string] = []
        for val in db_cursor.fetchall():
            link = '/recipes/' + str(val[1]).replace(' ', '_') + '/' + str(val[0])
            retval[search_string].append((val[1], link))
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval


def search_ingredients(search_string):
    retval = {}
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        search_string = '%' + db.escape_string(search_string) + '%'
        db_cursor.execute("SELECT recipe_id, name FROM recipes NATURAL JOIN ingredients_used WHERE ingredient_name LIKE %s;", search_string)
        db.commit()
        retval[search_string] = []
        for val in db_cursor.fetchall():
            link = '/recipes/' + str(val[1]).replace(' ', '_') + '/' + str(val[0])
            retval[search_string].append((val[1], link))
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval


def search_text(search_string):
    retval = search_recipes(search_string)
    retval.update(search_ingredients(search_string))
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        search_string = db.escape_string(search_string)
        db_cursor.execute("SELECT recipe_id, name FROM recipes NATURAL JOIN instructions WHERE MATCH instruction_text AGAINST (%s IN BOOLEAN MODE);", search_string)
        db.commit()
        values = db_cursor.fetchall()
        for val in values:
            link = '/recipes/' + str(val[1]).replace(' ', '_') + '/' + str(val[0])
            retval[search_string].append((val[1], link))
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval


def get_ingredients():
    retval = {}
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        db_cursor.execute("SELECT * FROM ingredients;")
        db.commit()
        for val in db_cursor.fetchall():
            retval[val[0]] = val[1]
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval

def get_recipes():
    retval = {}
    ingredient = {}
    val = []
    db = connect_db('cs4750roe2pjc', 'PASSWORD')
    db_cursor = db.cursor()
    try:
        db_cursor.execute("SELECT * FROM recipes NATURAL JOIN instructions NATURAL JOIN ingredients_used;")
        db.commit()
        val.append(db_cursor.fetchall())
        while val:
            current_row = val.pop()
            ingredient[current_row[0]].append((current_row[3], current_row[4]))
            retval[current_row[0]] = [current_row[1], current_row[2], ingredient[current_row[0]]]
    except Exception as e:
        print e.message
    finally:
        db_cursor.close()
        db.close()
        return retval

def build_export_file(cur_directory):
    descriptor = os.path.join(cur_directory, 'breadlosers.xml')
    with open(descriptor, 'w') as exportFile:
        ingredients_list = get_ingredients()
        recipe = get_recipes()



def password_hash(password):
    """Returns a hex format hash of the input password. Input password should contain salt already."""
    return hashlib.sha512(password).hexdigest()


def buildNavigation(recipe_categories):
    recipe_pages = []
    for category in recipe_categories:
        recipe_pages.append(NavigationItem(category))
    return recipe_pages

class NavigationItem:
    href = ''
    caption = ''

    def __init__(self, captionIn):
        if captionIn == 'Home':
            self.href = '../'
        elif captionIn == 'Export':
            self.href = '/export/'
        else:
            self.href = '/categories/' + str.replace(captionIn, " ", "_").lower()
        self.caption = captionIn


def main():
    val0 = user_create('test', 'user', 'nope@nope.com')
    val1 = authenticate_user('test', 'user')
    categories = get_categories()
    recipes = get_recipes(categories[1])
    recipe = load_recipe(1)
    comments = load_comments(1)
    print val0, val1
    print categories
    print recipes
    print recipe
    print comments

if __name__ == '__main__':
    main()
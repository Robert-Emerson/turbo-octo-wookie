__author__ = 'robert emerson'

#imports
from flask import Flask, render_template, request, redirect, url_for, flash, send_from_directory
from flask.ext.login import LoginManager, login_user, logout_user, current_user, login_required
import web_methods
import User

# create our little application
app = Flask(__name__)
app.config.from_object(__name__)
app.secret_key = "NOT ALL THAT SECRET REALLY"
login_manager = LoginManager()
login_manager.init_app(app)
recipe_categories = web_methods.get_categories()
navigation = web_methods.buildNavigation(recipe_categories)
recipe_cache = {}

@app.route('/')
def index():
    if current_user.get_id() == 'admin':
        navigation.append(web_methods.NavigationItem('Export'))
    log_action = 'Login'
    if current_user.is_authenticated():
        log_action = 'Logout'
    title = 'Home'
    subtitle = ""
    return render_template('main.html', navigation=navigation, title=title, subtitle=subtitle, log_action=log_action)


@app.route('/recipes/<name>/<recipe_id>')
def recipe(name, recipe_id):
    log_action = 'Login'
    if current_user.is_authenticated():
        navigation.append(web_methods.NavigationItem("New Recipe"))
        log_action = 'Logout'
    name = name.encode('utf8')
    title = str.replace(name, '_', " ")
    try:
        recipe = recipe_cache[name + str(recipe_id)]
    except KeyError:
        for word in title:
            str(word).capitalize()
        recipe = web_methods.load_recipe(recipe_id)
        recipe_cache[name + str(recipe_id)] = recipe
    finally:
        comments = web_methods.load_comments(recipe_id)
        return render_template('recipe.html', navigation=navigation, title=title, ingredients=recipe[0], instructions=recipe[1], pictures=recipe[2], log_action=log_action, comments=comments)


@app.route('/export/')
def export_data():
    if current_user.get_id() != 'admin':
        return redirect(url_for('index'))
    else:
        web_methods.build_export_file(app.root_path)
        send_from_directory(app.root_path, 'breadlosers.xml')

@app.route('/comments/', methods=['POST'])
def create_comment():
    recipe_id = request.form['recipe_id']
    name = request.form['name']
    name = str(name).replace(" ", "_")
    rating = request.form['rating']
    comment_text = request.form['commenttext']
    if not current_user.is_authenticated():
        flash("You must be logged in to comment")
        return redirect(url_for('recipe', name=name, recipe_id=recipe_id))
    else:
        username = current_user.get_id()
        web_methods.insert_comment(username, recipe_id, comment_text, rating)
        return redirect(url_for('recipe', name=name, recipe_id=recipe_id))


@app.route('/search/', methods=['POST'])
def search():
    log_action = 'Login'
    if current_user.is_authenticated():
        log_action = 'Logout'
    search_string = request.form['search_string']
    search_select = str(request.form['search_select']).lower()
    if search_select == 'recipes':
        title = "Recipes like " + search_string
        recipes = web_methods.search_recipes(search_string)
    elif search_select == 'ingredients':
        title = "Recipes using " + search_string
        recipes = web_methods.search_ingredients(search_string)
    else:
        title = "Recipes with " + search_string
        recipes = web_methods.search_text(search_string)
    return render_template('categories.html', navigation=navigation, title=title, subtitle="", recipe=title, recipes=recipes, log_action=log_action)


@app.route('/create_user/', methods=['GET', 'POST'])
def create_user():
    error = None
    next = request.args.get('next')
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        if web_methods.user_create(username, password, email):
            flash("You have registered")
            return redirect(next or url_for('index', error=error))
    return render_template('create_user.html', login=True, next=next, error=error, navigation=navigation, title="Register")

@app.route('/favorite/', methods=['POST'])
def create_favorite():
    recipe_id = request.form['recipe_id']
    name = request.form['name']
    name = str(name).replace(" ", "_")
    if not current_user.is_authenticated():
        flash("You must be logged in to comment")
        print url_for('recipe', name=name, recipe_id=recipe_id)
        return redirect(url_for('recipe', name=name, recipe_id=recipe_id))
    else:
        username = current_user.get_id()
        web_methods.insert_favorite(username, recipe_id)
        return redirect(url_for('recipe', name=name, recipe_id=recipe_id))

@app.route('/ingredients/', methods=['GET'])
def ingredients():
    log_action = 'Login'
    if current_user.is_authenticated():
        log_action = 'Logout'
    ingredients = web_methods.get_ingredients()
    title = "Ingredients"
    return render_template('ingredients.html', navigation=navigation, title=title, ingredients=ingredients, log_action=log_action)

@app.route('/categories/<name>')
def category(name):
    log_action = 'Login'
    if current_user.is_authenticated():
        log_action = 'Logout'
    name = name.encode('utf8')
    title = str.replace(name, '_', " ").capitalize()
    if name == '' or str.lower(name) == 'all':
        subtitle = "All"
        #expectes recipes to be dictionary with category - recipe title pairs
        recipes = web_methods.get_recipes('*')
        return render_template('categories.html', navigation=navigation, title=title, subtitle=subtitle, recipe=title, recipes=recipes, log_action=log_action)
    else:
        subtitle = name
        recipes = web_methods.get_recipes(name)

        return render_template('categories.html', navigation=navigation, title=title, subtitle=subtitle, recipe=title, recipes=recipes, log_action=log_action)


@app.errorhandler(404)
def page_not_found(error):
    return render_template('error.html'), 404 #TODO write a creative 404 page


@login_manager.user_loader
def load_user(user_id):
    return User.get_by_username(user_id)


@app.route('/login', methods=['GET', 'POST'])
@app.route('/Login', methods=['GET', 'POST'])
def login():
    error = None
    next = request.args.get('next')
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if web_methods.authenticate_user(username, password):
            user = User.get_by_username(username)
            if user:
                if login_user(user):
                    flash("You have logged in")
                    return redirect(next or url_for('index', error=error))
        error = "Login failed"
    return render_template('login.html', login=True, next=next, error=error, navigation=navigation, title="Login")


@app.route('/logout')
@app.route('/Logout')
@login_required
def logout():
    logout_user()
    flash('You have logged out')
    return(redirect(url_for('login')))

if __name__ == '__main__':
    app.run(debug=True)

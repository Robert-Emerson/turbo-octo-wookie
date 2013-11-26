__author__ = 'robert emerson'

#imports
from flask import Flask, render_template
import web_methods

#configuration
recipe_categories = ['Appetizers', 'Main Dishes', 'Side Dishes', 'Desserts', 'All']

# create our little application :)
app = Flask(__name__)
app.config.from_object(__name__)

@app.route('/')
@app.route('/index/')
@app.route('/home/')
def main():
    navigation = buildNavigation()
    title = 'Home'
    subtitle = ""
    return render_template('main.html', navigation=navigation, title=title, subtitle=subtitle)

@app.route('/recipes/<name>')
def recipe(name):
    recipes = {'recipe title': ['step1', 'step2']}
    name = name.encode('utf8')
    navigation = buildNavigation()
    title = str.replace(recipe, '_', " ").capitalize()
    subtitle = ""
    return render_template('recipe.html', navigation=navigation, title=title, subtitle=subtitle, recipe=title, recipes=recipes)

@app.route('/categories/<name>')
def category(name):
    name = name.encode('utf8')
    navigation = buildNavigation()
    title = str.replace(name, '_', " ").capitalize()
    if name == '' or str.lower(name) == 'all':
        subtitle = "All"
        recipes = web_methods.get_recipes('*')
        return render_template('recipe.html', navigation=navigation, title=title, subtitle=subtitle, recipe=title, recipes=recipes)
    else:
        subtitle = name
        recipes = web_methods.get_recipes(name)
        return render_template('recipe.html', navigation=navigation, title=title, subtitle=subtitle, recipe=title, recipes=recipes)


@app.errorhandler(404)
def page_not_found(error):
    return render_template('error.html'), 404 #TODO write a creative 404 page


def buildNavigation():

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
        else:
            self.href = '../categories/' + str.replace(captionIn, " ", "_")
        self.caption = captionIn

if __name__ == '__main__':
    app.run()

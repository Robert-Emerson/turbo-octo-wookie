__author__ = 'robert emerson'

#imports
from flask import Flask, render_template
import MySQLdb

#configuration
DATABASE =  MySQLdb.connect(host="stardock.cs.virginia.edu", user="cs4750roe2pj", passwd="NOT_MY_PASSWORD", db="cs4750roe2pj")
recipe_categories = ['home', 'appetizers', 'main dishes', 'side dishes', 'desserts', 'all']

# create our little application :)
app = Flask(__name__)
app.config.from_object(__name__)

@app.route('/')
@app.route('/index/')
@app.route('/home/')
def index():
    navigation = buildNavigation()
    title = 'home'
    subtitle = ""
    return render_template('index.html', navigation=navigation, title=title, subtitle=subtitle)

@app.route('/recipes/<name>')
def recipe():
    pass

@app.errorhandler(404)
def page_not_found(error):
    return render_template('index.html'), 404 #TODO write a creative 404 page

def buildNavigation():

    recipe_pages = []
    for category in recipe_categories:

        recipe_pages.append(NavigationItem(category))
    return recipe_pages

class NavigationItem:
    href = ''
    caption = ''

    def __init__(self, captionIn):
        if captionIn == 'home':
            self.href = '../'
        else:
            self.href = '../recipes/' + str.replace(captionIn, " ", "_")
        self.caption = captionIn

if __name__ == '__main__':
    app.run()

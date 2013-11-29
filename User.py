__author__ = 'robert'
from flask.ext.login import UserMixin
import web_methods


class User(UserMixin):

    def __init__(self, userIn, passIn, emailIn, saltIn):
        self.username = userIn
        self.password = passIn
        self.email = emailIn
        self.salt = saltIn

    def get_id(self):
        return unicode(self.username)

def get_by_username(username):
    db = web_methods.connect_db('cs4750roe2pjb', 'userregister')
    db_cursor = db.cursor()
    username = db.escape_string(username)
    args = [username]
    db_cursor.callproc("cs4750roe2pj.login_user", args)
    db.commit()
    result = db_cursor.fetchone()
    if not result:
        return None
    else:
        return User(result[0], result[1], result[2], result[3])
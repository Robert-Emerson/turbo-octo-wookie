__author__ = 'robert'


class User():
    password = ''
    username = ''

    def __init__(self, userIn, passIn):
        self.username = userIn
        self.password = passIn

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return unicode(self.username)
import hashlib
import uuid

__author__ = 'robert'

import pymysql
import uuid


def connect_db(user, password):
    db_connection = pymysql.connect(host="stardock.cs.virginia.edu", user=user, passwd=password, db="cs4750roe2pj")
    return db_connection


def close_db(db_connection):
    db_connection.close()


def user_login(username, password):
    db = connect_db('cs4750roe2pjb', 'PASSWORD')
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


def password_hash(password):
    """Returns a hex format hash of the input password. Input password should contain salt already."""
    return hashlib.sha512(password).hexdigest()


def main():
    val0 = user_create('test', 'user', 'nope@nope.com')
    val1 = user_login('test', 'user')
    print val0, val1

if __name__ == '__main__':
    main()
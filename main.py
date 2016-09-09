import os

import bottle
from beaker.middleware import SessionMiddleware

import config
import controllers

app = bottle.app()

session_opts = {
    'session.cookie_expires': True,
    'session.encrypt_key': 'please use a random key and keep it secret!',
    'session.httponly': True,
    'session.timeout': 3600 * 24,  # 1 day
    'session.type': 'cookie',
    'session.validate_key': True,
}
app = SessionMiddleware(app, session_opts)

if __name__ == '__main__':
    config.create_users()
    bottle.debug(True)
    port = int(os.environ.get('PORT', 8086))
    bottle.run(app=app, host='0.0.0.0', port=port, debug=True, reloader=True)

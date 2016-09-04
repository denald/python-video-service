import logging
import os
import subprocess

import bottle
from beaker.middleware import SessionMiddleware
from bottle import route, run, template, static_file, redirect
from cork import Cork

from exception import ConfigurationException

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)

aaa = Cork('conf')
authorize = aaa.make_auth_decorator(fail_redirect="/login", role="user")

app = bottle.app()
app.config.load_config('config.ini')
root_folder = app.config['app.root_folder']

session_opts = {
    'session.cookie_expires': True,
    'session.encrypt_key': 'please use a random key and keep it secret!',
    'session.httponly': True,
    'session.timeout': 3600 * 24,  # 1 day
    'session.type': 'cookie',
    'session.validate_key': True,
}
app = SessionMiddleware(app, session_opts)


# #  Bottle methods  # #

def postd():
    return bottle.request.forms


def post_get(name, default=''):
    return bottle.request.POST.get(name, default).strip()


if not root_folder:
    raise ConfigurationException("Root folder can't be empty! Set root_folder value in config.ini file")


@bottle.post('/login')
def login():
    """Authenticate users"""
    username = post_get('username')
    password = post_get('password')
    aaa.login(username, password, success_redirect='/', fail_redirect='/login')


@bottle.route('/login')
@bottle.view('login_form')
def login_form():
    """Serve login form"""
    return {}


@bottle.route('/logout')
def logout():
    aaa.logout(success_redirect='/login')


@bottle.route('/user_is_anonymous')
def user_is_anonymous():
    if aaa.user_is_anonymous:
        return 'True'

    return 'False'


@route('/')
@authorize()
def index():
    files = os.listdir(root_folder)
    return template('index', files=files)


@route('/play/<filename:path>')
def play(filename):
    return static_file(filename, root=root_folder, download=filename)


@route('/download/<filename:path>')
def download_file(filename):
    return static_file(filename, root=root_folder, download=True)


@route('/delete/<filename:path>')
def delete(filename):
    try:
        os.remove(root_folder + "{filename}".format(filename=filename))
    except OSError as e:
        logging.warn(e)
    redirect("/")


@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')


@route('/convert/<filename:path>')
def convert_to_mp4(filename):
    command = ['ffmpeg',
               '-y',
               '-i', root_folder + '{}'.format(filename),
               '-strict', '-2',
               root_folder + '{}'.format(filename.replace('.avi', '.mp4'))]
    logging.warn('Start conversion {} to .mp4 format'.format(filename))
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
    err = process.communicate()  # wait until process finished
    logging.warn(err)
    redirect("/")


# Web application main


if __name__ == '__main__':
    bottle.debug(True)
    port = int(os.environ.get('PORT', 8080))
    run(app=app, host='0.0.0.0', port=port, debug=True, reloader=True)

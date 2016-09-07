import logging
import os
import subprocess

import bottle
from bottle import route, static_file, redirect
from cork import Cork

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)

aaa = Cork('conf')
authorize = aaa.make_auth_decorator(fail_redirect="/login", role="user")

# Change to read from config file
root_folder = "/video/"


# #  Bottle methods  # #

def postd():
    return bottle.request.forms


def post_get(name, default=''):
    return bottle.request.POST.get(name, default).strip()


def is_admin():
    if aaa.current_user.role == "admin":
        return True

    return False


@bottle.post('/login')
def login():
    """Authenticate users"""
    username = post_get('username')
    password = post_get('password')
    aaa.login(username, password, success_redirect='/', fail_redirect='/login')
    log.debug("User {} logged in".format(username))


@bottle.route('/login')
@bottle.view('login_form')
def login_form():
    """Serve login form"""
    return {}


@bottle.route('/logout')
def logout():
    aaa.logout(success_redirect='/login')
    log.debug("User {} log out".format(aaa.current_user.username))


@route('/')
@authorize()
@bottle.view('index')
def index():
    files = os.listdir(root_folder)
    return dict(files=files, admin=is_admin(), user=aaa.current_user)


@route('/play/<filename:path>')
@authorize()
def play(filename):
    return static_file(filename, root=root_folder, download=filename)


@route('/download/<filename:path>')
@authorize()
def download_file(filename):
    return static_file(filename, root=root_folder, download=True)


@route('/upload', method='POST')
@bottle.view('index')
def upload_file():
    data = bottle.request.files.data
    if data and data.file:
        data.save(root_folder, overwrite=True)

        filename = data.filename
        log.debug("File {} successfully uploaded".format(filename))
    redirect("/")


@route('/delete/<filename:path>')
@authorize(role="admin", fail_redirect="/")
def delete(filename):
    try:
        os.remove(root_folder + "{filename}".format(filename=filename))
    except OSError as e:
        logging.warn(e)
        raise e
    log.debug("User {} deleted file {}".format(aaa.current_user.username, filename))
    redirect('/')


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
    log.debug("Execute command {}".format(command))
    log.warn('Start conversion {} to .mp4 format'.format(filename))
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
    err = process.communicate()  # wait until process finished
    log.warn(err)
    redirect("/")

import logging
import os
import subprocess

import bottle
import config
from bottle import route, static_file, redirect
from cork import Cork

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)

aaa = Cork('conf')
authorize = aaa.make_auth_decorator(fail_redirect="/login", role="user")


# #  Bottle methods  # #

def post_get(name, default=''):
    return bottle.request.POST.get(name, default).strip()


def is_admin():
    if aaa.current_user.role == "admin":
        return True

    return False


main_page = "/index"
login_page = "/login"


@bottle.post(login_page)
def login():
    """Authenticate users"""
    username = post_get('username')
    password = post_get('password')
    aaa.login(username, password, success_redirect=main_page, fail_redirect=login_page)
    log.debug("User {} logged in".format(username))


@bottle.route("/")
@bottle.route(login_page)
@bottle.view('login')
def login_form():
    """Serve login form"""
    return {}


@bottle.route('/logout')
def logout():
    aaa.logout(success_redirect=login_page)
    log.debug("User {} log out".format(aaa.current_user.username))


@route(main_page)
@bottle.view('index')
@authorize()
def index():
    files = os.listdir(config.root_folder)
    return dict(files=files, admin=is_admin(), user=aaa.current_user)


@route('/play/<filename:path>')
@authorize()
def play(filename):
    return static_file(filename, root=config.root_folder, download=filename)


@route('/download/<filename:path>')
@authorize()
def download_file(filename):
    return static_file(filename, root=config.root_folder, download=True)


@route('/upload', method='POST')
@bottle.view('index')
def upload_file():
    data = bottle.request.files.data
    if data and data.file:
        data.save(config.root_folder, overwrite=True)

        filename = data.filename
        log.debug("File {} successfully uploaded".format(filename))
    redirect(main_page)


@route("/users")
@bottle.view('users')
@authorize(role="admin", fail_redirect="/index")
def users_page():
    return dict(admin=is_admin(), user=aaa.current_user, users=aaa.list_users())


@bottle.post("/user/add")
@authorize(role="admin", fail_redirect="/")
def add_user():
    username = post_get('username')
    password = post_get('password')
    email = post_get("email")
    aaa.create_user(username=username, password=password, email_addr=email, role="user")
    logging.warning("User {} with password {} added".format(username, password))
    redirect("/users")


@route('/delete/<filename:path>')
@authorize(role="admin", fail_redirect="/")
def delete(filename):
    try:
        os.remove(config.root_folder + "{filename}".format(filename=filename))
    except OSError as e:
        logging.warn(e)
        raise e
    log.debug("User {} deleted file {}".format(aaa.current_user.username, filename))
    redirect(main_page)


@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')


@route('/convert/<filename:path>')
def convert_to_mp4(filename):
    command = ['ffmpeg',
               '-y',
               '-i', config.root_folder + '{}'.format(filename),
               '-strict', '-2',
               config.root_folder + '{}'.format(filename.replace('.avi', '.mp4'))]
    log.debug("Execute command {}".format(command))
    log.warn('Start conversion {} to .mp4 format'.format(filename))
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
    err = process.communicate()  # wait until process finished
    log.warn(err)
    redirect("/")

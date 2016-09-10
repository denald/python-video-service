#!/usr/bin/env python
#
#
# Regenerate files in conf
import logging
import os
from datetime import datetime

from cork import Cork

root_folder = os.path.expanduser("~") + "/video/"


def create_root_folder():
    if not os.path.exists(root_folder):
        os.mkdir(root_folder)
    logging.warning("Video folder created at {}".format(root_folder))


def create_users():
    cork = Cork('conf', initialize=True)

    cork._store.roles['admin'] = 100
    cork._store.roles['editor'] = 60
    cork._store.roles['user'] = 50
    cork._store.save_roles()

    tstamp = str(datetime.utcnow())
    username = password = 'admin'
    cork._store.users[username] = {
        'role': 'admin',
        'hash': cork._hash(username, password),
        'email_addr': username + '@localhost.local',
        'desc': username + ' test user',
        'creation_date': tstamp
    }
    username = password = 'demo'
    cork._store.users[username] = {
        'role': 'user',
        'hash': cork._hash(username, password),
        'email_addr': username + '@localhost.local',
        'desc': username + ' test user',
        'creation_date': tstamp
    }
    cork._store.save_users()


if __name__ == '__main__':
    create_users()

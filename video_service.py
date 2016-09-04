import logging
import os
import subprocess

from bottle import route, run, template, static_file, redirect

root_folder = "/home/sergey/VideoRecorder/core/video/"


@route('/')
def name():
    files = os.listdir(root_folder)
    return template('index_html', files=files)


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
    except OSError:
        pass
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


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    run(host='0.0.0.0', port=port, debug=True, reloader=True)

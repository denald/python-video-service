import logging
import os
import subprocess

from bottle import route, run, template, static_file, redirect


@route('/')
def name():
    files = os.listdir("/home/sergey/VideoRecorder/core/video")
    return template('index_html', files=files)


@route('/play/<filename:path>')
def play(filename):
    return static_file(filename, root='/home/sergey/VideoRecorder/core/video', download=filename)


@route('/download/<filename:path>')
def download_file(filename):
    return static_file(filename, root='/home/sergey/VideoRecorder/core/video', download=True)


@route('/delete/<filename:path>')
def delete(filename):
    try:
        os.remove('/home/sergey/VideoRecorder/core/video/{filename}'.format(filename=filename))
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
               '-i', '/home/sergey/VideoRecorder/core/video/{}'.format(filename),
               '-strict', '-2',
               '/home/sergey/VideoRecorder/core/video/{}'.format(filename.replace('.avi', '.mp4'))]
    logging.warn('Start conversion {} to .mp4 format'.format(filename))
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
    err = process.communicate()  # wait until process finished
    logging.warn(err)
    redirect("/")


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    run(host='0.0.0.0', port=port, debug=True, reloader=True)

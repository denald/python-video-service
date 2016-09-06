import requests

files = {'data': open('/Users/sepi/Github/VideoREcorder/video/video_test_recording_2016_31_08_18_54_43.mp4', 'rb')}

r = requests.post('http://localhost:8086/upload', files=files)

print(r)

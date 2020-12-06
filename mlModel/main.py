import threading 
import time 
import argparse
import json


import tornado.ioloop
import tornado.web
import asyncio

from Xenia import *




parser = argparse.ArgumentParser()
parser.add_argument('-p', type=int, help='port to listen on', default=8000)
args = parser.parse_args()
port = args.p



class JobServerHandler(tornado.web.RequestHandler):
    def get(self):
        payload = 'hello world'
        self.write(payload)

    def post(self):
        data = self.get_body_argument("data", None)
        data = json.loads(data)
        data['acd'] = 4563
        self.write(data)

asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

app = tornado.web.Application([
    (r"/", JobServerHandler),
])

app.listen(port)

tornado.ioloop.IOLoop.current().start()




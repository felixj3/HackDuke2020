import threading 
import time 
import argparse
import json


import tornado.ioloop
import tornado.web
import asyncio

from Xenia import *


conn = create_connection('db/development.sqlite3')

sbert_model = InitBert()
gmaps = InitGMapAPI()


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

        if data['cmd'] == 'rating':
            # self.write(data)
            self.flush()

            InsertInstance(conn, data['u1'], data['u2'], data['rating'], sbert_model, gmaps)
        elif data['cmd'] == 'fetchStudy':
            
            # self.write(json.dumps([0,1,2,3,4]))
            self.write(json.dumps(InferenceRoom(conn, data['user'], None, sbert_model, gmaps, 'mlModel/Params')))
        else:
            self.write(123)



asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

app = tornado.web.Application([
    (r"/", JobServerHandler),
])

app.listen(port)

tornado.ioloop.IOLoop.current().start()





import tornado.ioloop
import tornado.web


import multiprocessing
import argparse
import socket
import time
import json

STTIME = time.time()
def log(msg):
    print('%s %s' % (time.strftime('%H:%M:%S', time.gmtime(time.time() - STTIME)), str(msg)))
    

parser = argparse.ArgumentParser()
parser.add_argument('-p', type=int, help='port to listen on', default=5000)
args = parser.parse_args()
port = args.p



def getURLs(crawlRange):
    # with open('data/url.txt', encoding='utf-8') as f:
    #     urlList = f.read().split('\n')

    # while True:
    #     lastItem = urlList.pop()
    #     if lastItem.strip():
    #         urlList.append(lastItem)
    #         break

    start, end = map(int, crawlRange.split(':'))

    with open('data/top-1m.csv', encoding='utf-8') as f:
        urlList = [next(f).split(',')[1].strip() for x in range(end)][start:end]

    urlList.reverse()

    return urlList

def onClientExit():
    global clientsRemain
    clientsRemain -= 1
    if clientsRemain == 0:
        log('done')
        dataQueue.put(-1)
        tornado.ioloop.IOLoop.current().stop()

class JobServerHandler(tornado.web.RequestHandler):
    def get(self):
        payload = 'hello world'
        # if urls:
        #     url = str(urls.pop())
        #     log('Crawling %d - %s' % (idx, url))
        #     payload = json.dumps((idx, url))
        # else:
        #     payload = '-1'
        #     onClientExit()
            
        self.write(payload)

    def post(self):
        data = self.get_body_argument("resultData", None)
        if data:
            dataQueue.put({
                'data': data,
                'idx': int(self.get_body_argument("idx"))
            })
        self.get()


app = tornado.web.Application([
    (r"/", JobServerHandler),
])

app.listen(port)

tornado.ioloop.IOLoop.current().start()




# def getCrawled():
#     with open('result.txt', encoding='utf-8') as f:
#         entries = f.read().split('\n')
#     doneFile = ''
#     doneList = []

#     for i in entries:
#         if i:
#             ent = json.loads(i)
#             if ent[1][0]:
#                 doneFile += i + '\n'
#                 doneList.append(ent[0])
#     with open('result.txt', 'w', encoding='utf-8') as f:
#         f.write(doneFile)
#     return doneList

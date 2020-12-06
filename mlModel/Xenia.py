#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 22:02:27 2020

@author: wzy
"""
import re
import sqlite3
import googlemaps
from LocDist import calcDist
import SentDist.USEModel as USEModel
from nltk.tokenize import word_tokenize
import numpy as np
import Model
from sentence_transformers import SentenceTransformer
from torch.utils.data import DataLoader
import torch
import datetime

from Model import *

def InitGMapAPI():
    KeyFile = open("key.txt", "r")
    key = KeyFile.read()
    gmaps = googlemaps.Client(key = key)
    return gmaps

def InitBert():
    sbert_model = SentenceTransformer('bert-base-nli-mean-tokens')
    return sbert_model

def create_connection(db_file='/db/development.sqlite3'):
    """ create a database connection to a SQLite database """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except:
        print("error")
    return conn
    
def getSize(conn):
    sizeQ = """" SELECT COUNT(*)
                 FROM feedbacks
                 """
    try:
        c = conn.cursor()
        c.execute(sizeQ)
        size = c.fetchall()
        return size[0]
    except:
        print("error")
    
def InvolvDot(conn, u1, u2):
    try:
        c = conn.cursor()
        c.execute("""SELECT category1, category2, category3, category4, category5,
                  category6, category7, category8, category9, category10, category11,
                  category12
                  FROM users
                  WHERE users.id = ?""", (u1, ))
        u1Dat = c.fetchall()[0]
        
        c.execute("""SELECT category1, category2, category3, category4, category5,
                  category6, category7, category8, category9, category10, category11,
                  category12
                  FROM users
                  WHERE users.id = ?""", (u2, ))
        u2Dat = c.fetchall()[0]
        u1Dat = [float(i)/sum(u1Dat) for i in u1Dat]
        u2Dat = [float(i)/sum(u2Dat) for i in u2Dat]
        tot = 0
        for i in range(12):
            tot = tot + u1Dat[i] * u2Dat[i]
        return tot
    except:
        print("error")

def CourseDis(conn, u1, u2, sbert_model):
    c = conn.cursor()
    c.execute("""SELECT course1, course2, course3, course4, course5 
                FROM users
                WHERE users.id = ?""", (u1, ))
    u1Number = c.fetchall()[0]
    c.execute("""SELECT subject1, subject2, subject3, subject4, subject5 
                FROM users
                WHERE users.id = ?""", (u1, ))
    u1Title = c.fetchall()[0]
    u1Courses = []
    for i in range(5):
        if u1Title[i]:
            major = re.search(r'\((.+)\)', u1Title[i]).group(1)
            course = "%s%s" % (major, u1Number[i])
            try:
                course[0]
                u1Courses.append(course)
            except:
                continue
    c.execute("""SELECT course1, course2, course3, course4, course5 
                FROM users
                WHERE users.id = ?""", (u2, ))
    u2Number = c.fetchall()[0]
    c.execute("""SELECT subject1, subject2, subject3, subject4, subject5 
                FROM users
                WHERE users.id = ?""", (u2, ))
    u2Title = c.fetchall()[0]
    u2Courses = []
    for i in range(5):
        if u2Title[i]:
            major = re.search(r'\((.+)\)', u2Title[i]).group(1)
            course = "%s%s" % (major, u2Number[i])
            try:
                course[0]
                u2Courses.append(course)
            except:
                continue
    dist = USEModel.WordSim(u1Courses, u2Courses, sbert_model)
    return dist

def HomeDis(conn, u1, u2, gmaps):
    try:
        c = conn.cursor()
        c.execute("""SELECT hometown
                FROM users
                WHERE users.id = ?""", (u1, ))
        u1Dat = c.fetchall()[0]
        
        c.execute("""SELECT hometown
                FROM users
                WHERE users.id = ?""", (u2, ))
        u2Dat = c.fetchall()[0]
        dist = calcDist(u1Dat, u2Dat, gmaps)
        return dist
    except:
        print("error")
        
def MajorDis(conn, u1, u2, sbert_model):
    try:
        c = conn.cursor()
        c.execute("""SELECT major
                FROM users
                WHERE users.id = ?""", (u1, ))
        u1Dat = c.fetchall()[0][0]
        
        c.execute("""SELECT major
                FROM users
                WHERE users.id = ?""", (u2, ))
        u2Dat = c.fetchall()[0][0]
        dist = USEModel.SingletSim(u1Dat, u2Dat, sbert_model)
        return dist
    except:
        print("error")

def GradDis(conn, u1, u2):
    try:
        c = conn.cursor()
        c.execute("""SELECT gradYear
                FROM users
                WHERE users.id = ?""", (u1, ))
        u1Dat = c.fetchall()[0][0]
        
        c.execute("""SELECT gradYear
                FROM users
                WHERE users.id = ?""", (u2, ))
        u2Dat = c.fetchall()[0][0]
        dist = u1Dat - u2Dat
        return dist
    except:
        print("error")

def getUserRoom(conn, u1):
    Query = """SELECT study_rooms.ratings
                FROM users, study_rooms
                WHERE users.id = ? AND study_rooms.id = users.study_room_id"""
    c = conn.cursor()
    c.execute(Query, (u1,))
    ratings = c.fetchall()[0][0]
    return ratings

def InsertInstance(conn, u1, u2, ratings, sbert_model, gmaps):
    courseDis = CourseDis(conn, u1, u2, sbert_model)
    homeDis = HomeDis(conn, u1, u2, gmaps)
    majorDis = MajorDis(conn, u1, u2, sbert_model)
    gradDis = GradDis(conn, u1, u2)
    involveDot = InvolvDot(conn, u1, u2)
    # ratings = getUserRoom(conn, u1)
    # ratings = 4
    dt = datetime.datetime.now()
    instanceId = int(dt.strftime("%Y%m%d%H%M%S"))
    dat = ((instanceId, courseDis, homeDis, majorDis, float(gradDis), involveDot, float(ratings), ), )
    try:
        c = conn.cursor()
        c.executemany("""INSERT INTO feedbacks(id, courseDis, homeDis, 
                      majorDis, gradDis, involvDot, rating) 
                      VALUES(?, ?, ?, ?, ?, ?, ?)""", dat)
        conn.commit()
    except:
        print("error")

def getData(conn):
    try:
        c = conn.cursor()
        c.execute("SELECT * FROM feedbacks")
        data = c.fetchall()
        return data
    except:
        print("error")

def SelectRooms(conn):
    Query = """SELECT id FROM study_rooms
                WHERE current_number_student < capacity
                """
    try:
        c = conn.cursor()
        c.execute(Query)
        data = c.fetchall()
        if len(data) >= 10:
            data = data[0:10]
        return data
    except:
        print("error")

def SelectUser(conn, roomID):
    Query = """SELECT id FROM users
                WHERE study_room_id = ?
                """
    try:
        c = conn.cursor(Query, (roomID))
        c.execute()
        data = c.fetchall()[0]
        return data
    except:
        print("error")

def InferenceRoom(conn, uid, model, sbert_model, gmaps, PATH="Params"):
    model = torch.load(PATH)
    model.eval()
    rooms = SelectRooms(conn)
    roomDict = {}
    for room in rooms:
        peers = SelectUser(conn, room)
        cum = []
        if len(peers) < 1:
            continue
        for peer in peers:
            courseDis = CourseDis(conn, uid, peer, sbert_model)
            homeDis = HomeDis(conn, uid, peer, gmaps)
            majorDis = MajorDis(conn, uid, peer,sbert_model)
            gradDis = GradDis(conn, uid, peer)
            involveDot = InvolvDot(conn, uid, peer)
            dat = ((courseDis, homeDis, majorDis, gradDis, involveDot))
            data_set = Model.XeniaData(dat)
            test_loader = DataLoader(data_set, batch_size = 1)
            predRating = Model.predict(test_loader, model)
            cum.append(predRating)
        avg = sum(cum)/len(cum)
        roomDict[room] = avg
    sortedDict = {k: v for k, v in sorted(roomDict.items(), key=lambda item: item[1])}
    idArr = []
    for item in sortedDict.items():
        idArr.append(item[0])
        if len(idArr >= 5):
            break
    return idArr
    
def TrainNN(conn):
    raw_data = getData(conn)
    Model.composeModel(raw_data)
    
#conn = create_connection()
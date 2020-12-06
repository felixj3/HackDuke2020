#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 17:40:13 2020

@author: wzy
"""

import nltk
#nltk.download('punkt')
import numpy as np

class SentVSP():
    def __init__(self, sentence, sbert_model):
        self.model = sbert_model
        self.vec = self.model.encode([sentence])[0]
    def cosineSim(self, v):
        return np.dot(self.vec, v) / (np.linalg.norm(self.vec) * np.linalg.norm(v))
    def simMeasure(self, target):
         sim = self.cosineSim(self.model.encode([target])[0])
         return sim
     
def SingletSim(u1, u2, sbert_model):
    u1Dat = SentVSP(u1, sbert_model)
    sim = u1Dat.simMeasure(u2)
    return sim

def WordSim(u1, u2, sbert_model):
    similarities = []
    if len(u1) == 0 or len(u2) == 0:
        return 0
    for u1Course in u1:
        currCourse = SentVSP(u1, sbert_model)
        for u2Course in u2:
            sim = currCourse.simMeasure(u2)
            similarities.append(sim)
    if len(similarities) > 5:
        similarities.sort()
        similarities = similarities[0:5]
    dist = sum(similarities)/len(similarities)
    return dist

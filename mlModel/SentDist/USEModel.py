#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 17:40:13 2020

@author: wzy
"""

import nltk
#nltk.download('punkt')
from nltk.tokenize import word_tokenize
import numpy as np
from sentence_transformers import SentenceTransformer
#sbert_model = SentenceTransformer('bert-base-nli-mean-tokens')

class SentVSP():
    def __init__(self, sentence, sbert_model):
        self.model = sbert_model
        self.vec = self.model.encode([sentence])[0]
    def cosineSim(self, v):
        return np.dot(self.vec, v) / (np.linalg.norm(self.vec) * np.linalg.norm(v))
    def simMeasure(self, target):
         sim = self.cosineSim(self.model.encode([target])[0])
         return sim

def UserCourseSim(u1, u2):
    similarities = []
    if len(u1) == 0 or len(u2) == 0:
        return 0
    for u1Course in u1:
        currCourse = SentVSP(u1)
        for u2Course in u2:
            sim = currCourse.simMeasure(u2)
            similarities.append(sim)
    if len(similarities) > 10:
        similarities.sort()
        similarities = similarities[0:10]
    dist = sum(similarities)/len(similarities)
    return dist

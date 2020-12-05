#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 15:21:27 2020

@author: wzy
"""

import csv
import json

rawJson = {"Academic":[],
           "Arts, Media, and Publications": [],
           "Athletic and Recreation":[],
           'Campus Governance': [],
           'Career and Professional':[],
           'Common Interest':[],
           'Community Building':[],
           'Environmental, Science, and Technology':[],
           'Faith, Religion, and Spirituality':[],
           "Personal Development and Wellbeing":[],
           'Political':[],
           'Service and Social Action':[]
           }

with open("clubs.csv", "r") as csv_file:
    csv_reader = csv.DictReader(csv_file, delimiter=',')
    for lines in csv_reader:
        if len(lines['Academic']) > 1:
            rawJson["Academic"].append(lines['Academic'])
        if len(lines['Arts, Media, and Publications']) > 1:
            rawJson["Arts, Media, and Publications"].append(lines['Arts, Media, and Publications'])
        if len(lines['Athletic and Recreation']) > 1:
            rawJson["Athletic and Recreation"].append(lines['Athletic and Recreation'])
        if len(lines['Campus Governance']) > 1:
            rawJson["Campus Governance"].append(lines['Campus Governance'])
        if len(lines['Career and Professional']) > 1:
            rawJson["Career and Professional"].append(lines['Career and Professional'])
        if len(lines['Common Interest']) > 1:
            rawJson["Common Interest"].append(lines['Common Interest'])
        if len(lines['Community Building']) > 1:
            rawJson["Community Building"].append(lines['Community Building'])
        if len(lines['Environmental, Science, and Technology']) > 1:
            rawJson["Environmental, Science, and Technology"].append(lines['Environmental, Science, and Technology'])
        if len(lines['Faith, Religion, and Spirituality']) > 1:
            rawJson["Faith, Religion, and Spirituality"].append(lines['Faith, Religion, and Spirituality'])
        if len(lines['Personal Development and Wellbeing']) > 1:
            rawJson["Personal Development and Wellbeing"].append(lines['Personal Development and Wellbeing'])
        if len(lines['Political']) > 1:
            rawJson["Political"].append(lines['Political'])
        if len(lines['Service and Social Action']) > 1:
            rawJson["Service and Social Action"].append(lines['Service and Social Action'])

with open("clubs.json", "w") as outfile:  
    json.dump(rawJson, outfile)
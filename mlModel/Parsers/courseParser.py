#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Dec  6 10:24:14 2020

@author: wzy
"""

import json
import re

with open("courses_raw.json", 'r') as json_file:
    course_li = json.load(json_file)

rec = {}
for major in course_li:
    majorAbbrev = major[0]
    majorAbbrev = majorAbbrev[majorAbbrev.find("(")+1:majorAbbrev.find(")")]
    courses = major[1]
    for course in courses:
        courseNum = re.sub('[^0-9]','', course[0])
        courseTitle = course[1]
        courseAbbrev = majorAbbrev + str(courseNum)
        rec[courseAbbrev] = courseTitle

with open("courses.json", 'w') as json_file:
    json.dump(rec, json_file)
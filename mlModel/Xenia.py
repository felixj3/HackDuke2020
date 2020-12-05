#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 13:23:05 2020

@author: wzy
"""

import googlemaps
from geopy.distance import geodesic
import RoomPairing

KeyFile = open("key.txt", "r")
key = KeyFile.read()

gmaps = googlemaps.Client(key = key)
def calcDist(origin, dest):
    oriCode = gmaps.geocode(origin)
    destCode = gmaps.geocode(dest)
    oriLat = oriCode[0]['geometry']['location']['lat']
    oriLng = oriCode[0]['geometry']['location']['lng']
    destLat = destCode[0]['geometry']['location']['lat']
    destLng = destCode[0]['geometry']['location']['lng']
    oriLngLat = (oriLat, oriLng)
    destLngLat = (destLat, destLng)
    dist = geodesic(oriLngLat,destLngLat).km
    return dist



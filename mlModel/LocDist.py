#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 13:23:05 2020

@author: wzy
"""

from geopy.distance import geodesic


def calcDist(origin, dest, gmaps):
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



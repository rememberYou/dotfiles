#!/usr/bin/env python3
#
# The main purpose of this script is to allow you to dynamically adjust
# the color temperature of your screen according to your location using
# redshift for your windows manager.
#
# Another cool feature of this script is that it allows you to easily
# publish the configuration of your windows manager to GitHub without
# revealing your location.

import json
import urllib.request

url = 'http://ipinfo.io/json'

def is_internet():
    """Tells if there is Internet access.

    Returns:
        bool: True if there is Internet access. Otherwise, False.

    """
    try:
        urllib.request.urlopen(url, timeout=1)
        return True
    except urllib.error.URLError:
        return False

def get_location():
    """Gets your location according to the WiFi signals.

    Returns:
        str: The location in the following format (lat,long).

    """
    try:
        return json.load(urllib.request.urlopen(url))
    except urllib.error.URLError:
        return None

def get_default(path):
    """Gets the default location.

    Returns:
        str: The default location stored in a file.

    """
    with open(path, 'r') as f:
        return f.read().replace('\n', '')

if __name__ == '__main__':
    if is_internet():
        print(get_location()['loc'].replace(',', ':'))
    else:
        print(get_default("/home/someone/Dropbox/shared/localization"))

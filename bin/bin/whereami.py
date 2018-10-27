#!/usr/bin/env python3
#
# The main purpose of this script is to allow you to dynamically adjust
# the color temperature of your screen according to your location using
# redshift for your windows manager.
#
# Another cool feature of this script is that it allows you to easily
# publish the configuration of your windows manager to GitHub without
# revealing your location.
#
# WARNING: if you use this script for the first time without Internet access
# the location will be wrong.

import json
import os
import urllib.request

DEST = os.environ["HOME"] + "/.local/share/localization"
URL = "http://ipinfo.io/json"

def is_internet():
    """Tells if there is Internet access.

    Returns:
        bool: True if there is Internet access. Otherwise, False.

    """
    try:
        urllib.request.urlopen(URL, timeout=1)
        return True
    except urllib.error.URLError:
        return False

def get_default(path):
    """Gets the default location.

    Returns:
        str: The default location stored in a file.

    """
    with open(path, 'r') as path_file:
        return path_file.read().replace('\n', '')

def get_location():
    """Gets your location according to the WiFi signals.

    Returns:
        str: The location in the following format (lat,long).

    """
    try:
        return json.load(urllib.request.urlopen(URL))
    except urllib.error.URLError:
        return None

def update_location(dest, location):
    """Update the localization file."""
    open(dest, 'w').close()
    with open(dest, "a") as dest_file:
        dest_file.write(location)
        
if __name__ == '__main__':
    if not os.path.isfile(DEST):
        with open(DEST, "w") as dest_file:
            dest_file.write("50.816427:4.335961")
            
    if is_internet():
        location = get_location()["loc"].replace(',', ':')
        update_location(DEST, location)
    elif os.path.isfile(DEST):
        location = get_default(DEST)
    print(location)

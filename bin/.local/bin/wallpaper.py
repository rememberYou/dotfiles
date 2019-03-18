#!/usr/bin/env python3

import argparse
import glob
import random
import time

# DEFAULT FOLDER
FOLDER_WALL = '/home/someone/Pictures/Wallpapers/2560x1440/'

def interval_wall(wallpapers, seconds):
    while True:
        time.sleep(seconds)
        rand_wall = random.choice(wallpapers)
        print(rand_wall)
        wallpapers.remove(rand_wall)
        if len(wallpapers) == 0:
            wallpapers = glob.glob(FOLDER_WALL + "*")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Set random wallpapers")
    parser.add_argument('--version', action='version', version='%(prog)s 0.1.0')
    parser.add_argument('-d', '--directory', type=str, nargs=1, help='specific the main folder')
    parser.add_argument('-t', '--time', type=int, nargs=1, help='interval of background changes')
    args = parser.parse_args()

    if args.directory:
        FOLDER_WALL = args.directory[0]

    wallpapers = glob.glob(FOLDER_WALL + "*")

    if args.time:
        interval_wall(wallpapers, args.time[0])
    else:
        print(random.choice(wallpapers))

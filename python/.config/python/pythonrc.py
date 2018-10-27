#!/usr/bin/env python3
#
# This script is executed at the start of each interactive python
# console when it is defined in the PYTHONSTARTUP environment variable.

import atexit
import os
import readline

xdg_data = os.environ.get("XDG_DATA_HOME", '%s/.local/share' % os.environ['HOME'])
python_history = '%s/python/python_history' % xdg_data

if not os.path.exists('%s/python' % xdg_data):
   os.makedirs('%s/python' % xdg_data)
if not os.path.exists(python_history):
   open(python_history, 'a').close()
readline.read_history_file(python_history)
atexit.unregister(readline.write_history_file)
atexit.register(readline.write_history_file, python_history)

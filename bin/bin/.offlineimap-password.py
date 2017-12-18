#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import subprocess

def mailpasswd(acct):
    """
    Returns the password of a mail.

    acct - An username
    """
    acct = os.path.basename(acct)
    path = "/home/someone/.passwd/%s.gpg" % acct
    args = ["gpg", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args).strip()
    except subprocess.CalledProcessError:
        return ""

if __name__ == '__main__':
    print(mailpasswd("gmail"))

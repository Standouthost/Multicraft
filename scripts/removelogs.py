#!/usr/bin/python
import os
import glob

for log in glob.glob('/home/minecraft/multicraft/servers/*/*.log'):
	os.remove(log)

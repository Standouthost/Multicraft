#!/usr/bin/python
import os
import socket
import subprocess
import sys
IP = sys.argv[1]
PORT = sys.argv[2]
ID = sys.argv[3]
DOMAIN = 'example.com'
ps = subprocess.Popen(["/usr/bin/php", "/home/minecraft/multicraft/api/name.php", ID], stdout=subprocess.PIPE).communicate()[0]
processes = ps.split('\n')
for row in processes[0:-1]:
  s = row.split('=> ')
  if 'name' in s[0]:
    NAME = s[1]
    format = NAME.split('.')
    if len(format) != 3:
        print 'Your domain name is not in the format of example.' + DOMAIN + ', please rectify this and try again'
        sys.exit(1)
    elif format[1] + "." + format[2] != DOMAIN:
        print "Your domain is not ending in " + DOMAIN + ", please rectify this and try again"
        print format[1] + format[2]
        sys.exit(1)
    try:
        with open("/home/dns/mc" + ID + ".SRV.txt", "w") as file:
            file.write('_minecraft._tcp.' + format[0] + ' 3600    IN  SRV 0   5  ' + PORT + ' ' + format[0] + '.' + DOMAIN + '. ; mc' + ID)
        print 'Your domain is now activated, it might take an hour for it to work'
    except:
        print "Error"
        sys.exit(1)
    try:
        with open("/home/dns/mc" + ID + ".A.txt", "w") as file:
            file.write(format[0] + '             IN      A       ' + IP + '  ;  mc' + ID)
    except:
        print "Error"
        sys.exit(1)
    try:
        open('/home/dns/work', 'w').close()
    except:
        print "Error"
        sys.exit(1)

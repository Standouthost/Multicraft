#!/usr/bin/python
import os
import time
import subprocess

ZONE = '/etc/nsd/example.com'

def SERIAL(file):	# Set the serial number in the file
    "Update line containing serial"
    f = open(file, 'r')
    lines = f.readlines()
    f.close()
    currentdate = time.strftime("%Y%m%d")
    for line in lines:
       if '; serial number YYYYMMDDnn' in line:
          serialdate = line.split(';')[0].strip()[0:-2]
          nn = int(line.split(';')[0].strip()[-2:])
    if serialdate == currentdate:
       nn += 1
       nn = str(nn).zfill(2)
       serial = currentdate + nn
    else:
       serial = currentdate + "01"
    f = open(file, "w")
    for line in lines:
       if '; serial number YYYYMMDDnn' not in line:
          f.write(line)
       else:
          newline = '                        ' + serial + '      ; serial number YYYYMMDDnn\n'
          f.write(newline)

def LIMITONE(file, ID):		# Remove line with mcxxx
    "Remove existing entry for specific ID"
    f = open(file, 'r')
    lines = f.readlines()
    f.close()
    f = open(file, 'w')
    for line in lines:
       if ID not in line:
          f.write(line)
    f.close

def ARECORD(file, string):	# Open zone and read each line for A record
   "Print each line in zone"
   with open(file) as f:
     result = 'PASS'
     for line in f:
        s = line.split()
        if len(s) > 3:
           #If record already exists, do not overwrite it
           if string ==  s[0]:
              result = 'FAIL'
   return result

def SRVRECORD(file, string):	# Open zone and read each line for SRV record
   "Print each line in zone"
   with open(file) as f:
      result = 'PASS'
      for line in f:
         s = line.split()
         if '.' in s:
            srv = s.split('.')
            if len(srv) == 3:
               #If record already exists, do not overwrite it
               if string == srv[3]:
                  return 'FAIL'
   return result


if os.path.isfile('/home/dns/work'):

   #Process the A record
   for file in os.listdir("/home/dns"):
      if file.endswith("A.txt"):
         with open('/home/dns/' + file) as f:
            for line in f:
               s = line.split()[0]
               ID = line.split(';')[1].strip()
               LIMITONE(ZONE, ID)
               if ARECORD(ZONE, s) != 'FAIL':
                  with open(ZONE, "a") as dns:
                     dns.write(line + '\n')
               else:
                  print 'A RECORD FAIL'
         os.remove('/home/dns/' + file)
   #Process the SRV record
   for file in os.listdir("/home/dns"):
      if file.endswith("SRV.txt"):
         with open('/home/dns/' + file) as f:
            for line in f:
               s = line.split()[0].split('.')[2]
               if SRVRECORD(ZONE, s) != 'FAIL':
                  with open(ZONE, "a") as dns:
                     dns.write(line + '\n')
               else:
                  print 'SRV RECORD FAIL'
         os.remove('/home/dns/' + file)
   #Remove the file indicating work is needed
   os.remove('/home/dns/work')
   #Update the serial
   SERIAL(ZONE)
   #Restart nsd, and sync to other name servers
   subprocess.call("/etc/nsd/restart.sh", shell=True)

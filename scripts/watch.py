#!/usr/bin/python
import os
import xmpp
import socket
import subprocess

def sendXmpp(x,y):    #send message over xmpp
    "Send a message over xmpp"
    hostname=socket.gethostname()
    username = 'multicraft.example'
    passwd = 'examplepassword'
    to='%s' % y
    msg='%s %s' % (hostname, x)
    client = xmpp.Client('soh.re')
    client.connect(server=('de.soh.re',5222))
    client.auth(username, passwd, 'botty')
    client.sendInitPresence()
    message = xmpp.Message(to, msg)
    message.setAttr('type', 'chat')
    client.send(message)

#Check for defunct processes with ps -ef
ps = subprocess.Popen(['ps', '-ef'], stdout=subprocess.PIPE).communicate()[0]
processes = ps.split('\n')
for row in processes[1:]:
  if "[java] <defunct>" in row:
    sendXmpp(row,'me@example.com')


#Check for broken pipe
with open('/home/minecraft/multicraft/multicraft.log') as f:
  for line in f:    
    if "Error writing to server: [Errno 32] Broken pipe" in line:
      s = line.split()
      SERVER = s[4].split(':')[0]
      subprocess.call(["/usr/bin/php", "/home/minecraft/multicraft/api/restart.php", SERVER])
      killmsg = 'mc%s had a broken pipe so I restarted it.' % (SERVER)
      sendXmpp(killmsg,'me@example.com')
#Check for Wrong jar
    if "Error: Unable to access jarfile" in line:
      sendXmpp(line,'me@example.com')
#Emtpy the log
open('/home/minecraft/multicraft/multicraft.log', 'w').close()

#Stanton figured out the load = line
#Check if load is above 15, IM if it is
load = os.getloadavg()
if load[0] > 15:
  loadmsg = 'Load is: %s' % (load[0])
  sendXmpp(loadmsg,'me@example.com')

#Check for zombie dead mc servers, kill and restart them
ps = subprocess.Popen(['ps', '-ef'], stdout=subprocess.PIPE).communicate()[0]
processes = ps.split('\n')
for row in processes[0:-1]:
  s = row.split()
  if "mc" in s[0] and s[2] == '1':
      killmsg = 'killed and restarted this process \n %s' % (row)
      sendXmpp(killmsg, 'me@example.com')
      PID = int(s[1])
      os.kill(PID, 9)
      SERVER = s[0].split('mc')[1]
      subprocess.call(["/usr/bin/php", "/home/minecraft/multicraft/api/restart.php", SERVER])

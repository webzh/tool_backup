#!/bin/bash
StandardOutput=syslog+console
StandardError=inherit
SyslogIdentifier=xxxx



xxxService



if ($programname == 'zzzz') then {
   action(type="omfile" file="/data/logs/zzzz.log")
   stop
} else if ($programname == 'xxxx') then {
   action(type="omfile" file="/data/logs/xxxx.log")
   stop
}


/data/logs/xxx/*.log {
  daily
  dateext
  rotate 10
  missingok
  notifempty
  compress
  sharedscripts
  olddir /data/logs/goservice/backup_go_log
  postrotate
      systemctl restart rsyslog
  endscript
}
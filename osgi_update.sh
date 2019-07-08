#!/usr/bin/expect -f


set IP "[lrange $argv 0 0]"
set IOT_TARGET "[lrange $argv 2 2]"
set BUNDLE_ID "[lrange $argv 1 1]"

spawn /usr/bin/telnet $IP 5002
expect "*osgi>"
send "update $BUNDLE_ID file:$IOT_TARGET\r"
expect "*osgi>"
send '^]\r'
send 'q\r'

puts "\n"

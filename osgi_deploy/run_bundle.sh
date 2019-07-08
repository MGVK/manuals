#!/usr/bin/expect -f

set IP "[lrange $argv 0 0]"
set BUNDLE_ID "[lrange $argv 1 1]"

puts "start $BUNDLE_ID\r"

spawn /usr/bin/telnet $IP 5002
expect "*osgi>"
send "start $BUNDLE_ID\r"
expect "*osgi>"
send '^]\r'
send 'q\r'

puts "\n"

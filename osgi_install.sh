#!/usr/bin/expect -f

set IP "[lrange $argv 0 0]"
set IOT_TARGET "[lrange $argv 1 1]"

puts "installing..... $IOT_TARGET"

spawn /usr/bin/telnet $IP 5002
expect "*osgi>"
send "install file:$IOT_TARGET\r"
expect "*osgi>"
send '^]\r'
send 'q\r'

puts "\n"

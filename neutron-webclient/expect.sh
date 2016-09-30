#!/usr/bin/expect
set send_slow {1 .1}
set timeout 600

spawn make build-client

expect {
  timeout { send -- "7\r"; exp_continue }
}

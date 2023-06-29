#!/bin/bash

api="https://api.vpnrapid.net"
user_agent="okhttp/4.9.1"
version="1.2.5"
model="RMX3551"
manufacturer="realme"
package="com.rapidconn.android"
chid=$(shuf -i 100000-999999 -n 1)
android_id=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 | tr '[:upper:]' '[:lower:]')
device_user=$(echo -n "{\"chid\":\"$chid\",\"subchid\":\"1\",\"vc\":\"34\",\"uid\":\"0\",\"packageName\":\"$package\",\"pkg\":\"$package\",\"vn\":\"$version\",\"aid\":\"$android_id\",\"im\":\"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | tr '[:upper:]' '[:lower:]')\",\"os_type\":\"Android\",\"imei\":\"\",\"api\":28,\"release\":\"9\",\"abi\":\"arm64-v8a\",\"imsi\":\"\",\"rid\":\"\",\"brand\":\"$manufacturer\",\"manufacturer\":\"$manufacturer\",\"model\":\"$model\",\"product\":\"$model\",\"isHOS\":0}" | base64 -w 0)

function register() {
	curl --request POST \
		--url "$api/register" \
		--user-agent "$user_agent" \
		--header "device-user: $device_user" \
		--header "content-type: text/plain" \
		--data "$(head -c 18 /dev/urandom | base64 | tr -d '\n' | head -c 24; echo "==")"
}

function get_servers() {
	curl --request POST \
		--url "$api/accnode" \
		--user-agent "$user_agent" \
		--header "device-user: $device_user" \
		--header "content-type: text/plain" \
		--data "$(head -c 18 /dev/urandom | base64 | tr -d '\n' | head -c 24; echo "==")"
}

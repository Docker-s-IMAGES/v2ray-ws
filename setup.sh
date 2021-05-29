#!/bin/sh

domain="$1"

if [ ! "$2" ] ;then
    path="/confusion"
else
    path="$2"
fi

if  [ ! "$3" ] ;then
    uuid=$(uuidgen)
else
    uuid="$3"
fi

sed -i "s/uuid/${uuid}/" /src/v2ray.json

echo "安卓客户端 v2rayNG 配置链接："
echo -e "vmess://\c"
echo "{""add":"${domain}","aid":"64","host":"","id":"${uuid}","net":"ws","path":"${path}","port":"443","ps":"${domain}","tls":"tls","type":"none","v":"2""}" | base64

/usr/bin/v2ray -config /src/v2ray.json

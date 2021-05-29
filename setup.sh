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

sed -i -e "s@UUID@${uuid}@" -e "s@PATH@${path}@" /src/v2ray.json

echo "安卓客户端 v2rayNG 配置链接："
echo -e "vmess://\c"
echo '{"add":"DOMAIN","aid":"64","host":"","id":"UUID","net":"ws","path":"PATH","port":"443","ps":"DOMAIN","sni":"","tls":"tls","type":"none","v":"2"}' | sed -e "s@DOMAIN@${domain}@" -e "s@DOMAIN@${domain}@" -e "s@PATH@${path}@" -e "s@UUID@${uuid}@" | base64

/usr/bin/v2ray -config /src/v2ray.json

#!/bin/sh

UUID=${UUID:-'b62d9a04-da01-464a-821c-f0ea61f669af'}
VMESS_WSPATH=${VMESS_WSPATH:-"/${UUID}-vmess"}
VLESS_WSPATH=${VLESS_WSPATH:-"/${UUID}-vless"}
TROJAN_WSPATH=${TROJAN_WSPATH:-"/${UUID}-trojan"}
URL=${HOSTNAME}-8080.csb.app

sed -i "s#UUID#$UUID#g;s#VMESS_WSPATH#$VMESS_WSPATH#g;s#VLESS_WSPATH#$VLESS_WSPATH#g" /etc/mysql/config.json
sed -i "s#VMESS_WSPATH#$VMESS_WSPATH#g;s#VLESS_WSPATH#$VLESS_WSPATH#g" /etc/nginx/nginx.conf
sed -i "s#TROJAN_WSPATH#$TROJAN_WSPATH#g;" /etc/mysql/config.json
sed -i "s#TROJAN_WSPATH#$TROJAN_WSPATH#g" /etc/nginx/nginx.conf

# 设置 nginx 伪装站
rm -rf /usr/share/nginx/*
wget https://github.com/sandhikagalih/simple-landing-page/archive/master.zip -O /usr/share/nginx/mikutap.zip
unzip -d /usr/share/nginx/html /usr/share/nginx/mikutap.zip
rm -f /usr/share/nginx/mikutap.zip

cat > /usr/share/nginx/html/$UUID.html<<-EOF
<html>
<head>
<title>Codesandbox</title>
<style type="text/css">
body {
	  font-family: Geneva, Arial, Helvetica, san-serif;
    }
div {
	  margin: 0 auto;
	  text-align: left;
      white-space: pre-wrap;
      word-break: break-all;
      max-width: 80%;
	  margin-bottom: 10px;
}
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
HELLO WORLD .
# <div><font color="#009900"><b>VMESS协议链接：</b></font></div>
# <div>$vmlink</div>
# <div><font color="#009900"><b>VMESS协议二维码：</b></font></div>
# <div><img src="/M$UUID.png"></div>
# <div><font color="#009900"><b>VLESS协议链接：</b></font></div>
# <div>$vllink</div>
# <div><font color="#009900"><b>VLESS协议二维码：</b></font></div>
# <div><img src="/L$UUID.png"></div>
</body>
</html>
EOF

echo https://$URL/$UUID.html > /usr/local/mysql/info
# exec "$@"

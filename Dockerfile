FROM ubuntu

RUN apt update -y && apt install -y wget unzip nginx supervisor net-tools

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/mysql /usr/local/mysql
COPY config.json /etc/mysql/
COPY entrypoint.sh /usr/local/mysql/

RUN wget -q -O /tmp/mikutap.zip https://github.com/AYJCSGM/mikutap/archive/master.zip && unzip -d /usr/share/nginx/html /tmp/mikutap.zip  && rm -f /tmp/mikutap.zip


RUN wget -q -O /tmp/tmp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -d /usr/local/mysql /tmp/tmp.zip && \
	mv /usr/local/mysql/xray /usr/local/mysql/mysql && \
    chmod a+x /usr/local/mysql/entrypoint.sh
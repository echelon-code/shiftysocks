# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu

MAINTAINER Yale Huang <calvino.huang@gmail.com>

# Commands to update the image
RUN apt-get -y update && apt-get -y upgrade && \
	apt-get install build-essential autoconf automake libtool libssl-dev git \
		wget supervisor libpcre3-dev libmbedtls-dev libsodium-dev libc-ares-dev libev-dev -y && \
	git clone https://github.com/shadowsocks/shadowsocks-libev.git /root/shadowsocks-libev && \
	cd /root/shadowsocks-libev && git checkout v3.1.3 && \
	git submodule update --init --recursive && \
	./autogen.sh && ./configure --help && ./configure --disable-documentation && make && \
	cd /root/shadowsocks-libev/src && install -c ss-server /usr/bin && \
	apt-get purge git build-essential autoconf automake libtool libssl-dev libpcre3-dev libmbedtls-dev libsodium-dev libc-ares-dev libev-dev -y && \
	apt-get autoremove -y && apt-get autoclean -y
RUN wget -O /root/kcptun-linux-amd64.tar.gz https://github.com/xtaci/kcptun/releases/download/v20171201/kcptun-linux-amd64-20171201.tar.gz && \
	mkdir -p /opt/kcptun && cd /opt/kcptun && tar xvfz /root/kcptun-linux-amd64.tar.gz && \
	rm -rf /root/shadowsocks-libev /root/kcptun-linux-amd64.tar.gz
COPY supervisord.conf /etc/supervisord.conf

ENV SS_PASSWORD=1234567 SS_METHOD=aes-256-cfb KCPTUN_PASSWORD=1234567 \
	MTU=1350 SNDWND=128 RCVWND=1024 MODE=fast

EXPOSE 41111/udp 8338/tcp

CMD ["/usr/bin/supervisord"]


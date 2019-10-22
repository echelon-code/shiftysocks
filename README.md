# shiftysocks

## Clients

I would recommend using Google's Outline software as it is multiplatform and stable. It is also free. See information page here: https://getoutline.org

## Quick Start

``Bootstrap`` will help you setup a worker container, without setting any
parameter manually. Just copy following line to your terminal and execute it:

```bash
docker run -t -i --rm --network=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  n0cebo/shiftysocks bootstrap
```

The worker container will be setup in seconds. Ports and passwords are generated
by ``Bootstrap`` automatically. And you will see the Shadowsocks links:

```
Current container: 2de5d0362e16ef4b134e471ec9ce7ecf47624496e5d92a4c404aaf669108d2d4
Current image:
Network interface: wlp58s0
Host name: 172.18.0.25
Exported Shadowsocks port: 15858
Exported KCPTUN port: 9974
Password: Z0lT4N5N

docker run -d --restart=always --name ss-15858-kcp-9974 -e SS_PASSWORD=Z0lT4N5N -e SS_METHOD=aes-256-cfb -e KCPTUN_MODE=normal -e KCPTUN_PASSWORD=Z0lT4N5N -e KCPTUN_SNDWND=256 -e KCPTUN_RCVWND=256 -e SS_LINK=ss://YWVzLTI1Ni1jZmI6b2hIb2g0YmlAMTcyLjE4LjAuMjU6MTU4NTg=#SS:172.18.0.25:15858 -e KCPTUN_SS_LINK=ss://YWVzLTI1Ni1jZmI6b2hIb2g0Ymk=@172.18.0.25:9974?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DZ0lT4N5N%3Bmtu%3D1350#KCP_SS%3A172.18.0.25%3A9974 -p 15858:8338/tcp -p 9974:41111/udp n0cebo/shiftysocks:runit

Worker container: 29d1d7206b99a809520792382a99ee350b2b8030e4bdf5566577e017e1dd8a5e
Worker container name: ss-15858-kcp-9974

----

Shadowsocks link: ss://YWVzLTI1Ni1jZmI6b2hIb2g0YmlAMTcyLjE4LjAuMjU6MTU4NTg=#SS:172.18.0.25:15858

QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A//YWVzLTI1Ni1jZmI6b2hIb2g0YmlAMTcyLjE4LjAuMjU6MTU4NTg%3D%23SS%3A172.18.0.25%3A15858

----

KCPTUN SS link (for Android client only): ss://YWVzLTI1Ni1jZmI6b2hIb2g0Ymk=@172.18.0.25:9974?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DZ0lT4N5N%3Bmtu%3D1350#KCP_SS%3A172.18.0.25%3A9974

QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A//YWVzLTI1Ni1jZmI6b2hIb2g0Ymk%3D%40172.18.0.25%3A9974%3Fplugin%3Dkcptun%253Bmode%253Dnormal%253Brcvwnd%253D256%253Bsndwnd%253D256%253Bkey%253DZ0lT4N5N%253Bmtu%253D1350%23KCP_SS%253A172.18.0.25%253A9974

```

Then, just import the above ``ss://`` links to your client to your client. It's
done!

### Optional

* Show Shadowsocks links and QR codes of a running worker container:

```
$ docker exec -it 4d658d2be455 show
Shadowsocks link: ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:15358#SS%3A192.168.0.175%3A15358
QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A%2F%2FYWVzLTI1Ni1jZmI6d3VXYWlsNFY%3D%40192.168.0.175%3A15358%23SS%253A192.168.0.175%253A15358

KCPTUN SS link: ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:14510?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DwuWail4V%3Bmtu%3D1350#KCP_SS%3A192.168.0.175%3A15358
QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A%2F%2FYWVzLTI1Ni1jZmI6d3VXYWlsNFY%3D%40192.168.0.175%3A14510%3Fplugin%3Dkcptun%253Bmode%253Dnormal%253Brcvwnd%253D256%253Bsndwnd%253D256%253Bkey%253DwuWail4V%253Bmtu%253D1350%23KCP_SS%253A192.168.0.175%253A15358
```

* To see the passwords and other parameters of Shadowsocks and KCPTUN:

```
docker inspect -f '{{range $_, $e := .Config.Env}}{{println $e}}{{end}}' <WORKDER_CONTAINER_ID>
```

* To avoid KCPTUN encryption overhead (SS payload is encrypted), KCPTUN crypt can be set to ``none``:

```bash
docker run -t -i --rm --network=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e KCPTUN_CRYPT=none \
  n0cebo/shiftysocks bootstrap
```

KCPTUN crypt option needs to be set at the client also to make it work.

The KCPTUN mode can also be changed from the "fast" default to fast2 or fast3:

```bash
docker run -t -i --rm --network=host \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -e KCPTUN_MODE=fast3 \
 n0cebo/shiftysocks bootstrap
```

KCPTUN crypt option needs to be set at the client also to make it work.

### Notice

* The links of QR code can be opened with your browser. They are QR code images
which can be scanned and imported by Shadowsocks Android client.
* ``Bootstrap`` can be executed for multiple times and you will get multiple
running worker containers.

## Manually

```bash
docker run -d --restart=always -e 'SS_PASSWORD=SHADOWSOCKS_PASSWORD' -e 'KCPTUN_PASSWORD=balancing' -p 8338:8338/tcp -p 41111:41111/udp --name=my-kcp-ss n0cebo/shiftysocks
```

* SS_PASSWORD: password for Shadowsocks
* KCPTUN_PASSWORD: password for kcptun
* TCP port mapping for 8338: optional, in case to export a Shadowsocks port without FinalSpeed
* UDP port mapping for 41111: required for kcptun

# docker-tinydns-gitdnsdata
Docker image running axfrdns (to be used in addition to docker-tinydns-gitdnsdata). Includes [fefe's ipv6 patches](https://www.fefe.de/dns/)

axfrdns server in a docker container. Uses a git repository to periodically pull and update the DNS data. Uses statically compiled binaries. The
repository at GIT_DNSDATA also needs to include a tcp file and an addition to the Makefile to compile the tcp.cdb.

### Variables

* **GIT_DNSDATA**: URL to pull the dns data from. See [example data](https://github.com/andreasfaerber/docker-tinydns-exampledata)
* **GIT_UPDATE_FREQUENCY**: Delay in seconds between each DNS data update

#### Run tinydns docker container with example data:

```
docker run -d \
  -e GIT_DNSDATA=\
"https://github.com/andreasfaerber/docker-tinydns-exampledata.git" \
  -e GIT_UPDATE_FREQUENCY=300 \
  -p 53:53/tcp \
  --name axfrdns_example \
  afaerber/docker-axfrdns-gitdnsdata
```

#### Run with ssh key authentication for some real world DNS data repository:

- Provide username and password via https to pull git repository via https
- Change the example GIT_DNSDATA URL to your DNS data repository
- Change GIT_UPDATE_FREQUENCY to suit your use

```
docker run -d \
  -e GIT_DNSDATA="https://username:password@your.git.url/repository.git" \
  -e GIT_UPDATE_FREQUENCY=300 \
  -p 53:53/tcp \
  --name axfrdns_example \
  afaerber/docker-axfrdns-gitdnsdata
```

#### Test example install

```
dig @127.0.0.1 your.example axfr
```

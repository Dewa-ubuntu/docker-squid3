## Build

```bash
git clone https://github.com/confirm-it-solutions/docker-squid3.git
cd docker-squid3
docker build -t <tag> .
```

## Run

```bash
docker run --name squid3 -v <squid3 config dir>:/etc/squid3 confirm/squid3
```

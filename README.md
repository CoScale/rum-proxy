# CoScale RUM proxy

RUM reverse proxy for CoScale on-premises that are not exposed to the internet.

# Instructions

* Set the ip:port for the proxy container to listen on
* Set destination to the hostname of the target env. Include the protocol http or https.
* Provide a https.key and https.crt in the /data/ssl volume (only needed if https is enabled)

```
docker run -d \
    -p 0.0.0.0:6080:80 \
    -p 0.0.0.0:6443:443 \
    -v $PWD/ssl:/data/ssl:ro \
    -e "ENABLE_HTTPS=1" \
    -e "DESTINATION=https://test.coscale.com/" \
    --name rumproxy coscale/rum-proxy:latest
```

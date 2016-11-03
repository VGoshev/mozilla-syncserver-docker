# Mozilla Firefox Sync Server Docker image
Docker image for [Mozilla Sync Server](https://github.com/mozilla-services/syncserver)

## Supported tags and respective `Dockerfile` links

* [`1.5.2-20160817`](https://github.com/SunAngel/mozilla-syncserver-docker/blob/1.5.2-20160817/docker/Dockerfile), [`latest`](https://github.com/SunAngel/mozilla-syncserver-docker/blob/master/docker/Dockerfile) - Latest avaliable version of Mozilla syncserver

## Quickstart

To run container you can use following command:
```bash
docker run \  
  -v /home/docker/ffsync:/home/ffsync \  
  -p 127.0.0.1:5000:5000 \  
  -d sunx/mozilla-syncserver-docker
```
Containers, based on this image will automatically create configuration file for
 Mozilla Syncserver with SQLite database.
 
## Detailed description of image and containers

### Used ports

This image uses 1 tcp ports:
* 5000 - Standart port of Mozilla Syncsrver 

### Volume
This image uses one volume with internal path `/home/ffsync`, it will store configuration file and SQLite database here

I would recommend you use host directory mapping of named volume to run containers, so you will not lose your valuable data after image update and starting new container

### Web server configuration

Mozilla Syncserver could work without any web-server, but I'd recommend you to use some web-server oh your host machine to add HTTPS support.

For frontend webserver configuration you can read official [Mozilla Syncserver manual](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#running-behind-a-web-server)

### Supported ENV variables

On first run of container you can use following ENV variables for Mozilla Syncerver configuration:
* **`PUBLIC_URL`**=&lt;http[s]://.../&gt; - public URL of your server, i.e. the URL as seen by Firefox. Default: `http://<container_hostname>/`.

## Firefox configuration

To configure desktop Firefox to talk to your new Sync server, go to `about:config`, search for `identity.sync.tokenserver.uri` and change its value to the URL of your server with a path of `token/1.0/sync/1.5`:

    identity.sync.tokenserver.uri: http://sync.example.com/token/1.0/sync/1.5

More details you can find in [Official Manual](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#running-the-server)

## License

This Dockerfile and scripts are released under [MIT License](https://github.com/SunAngel/mozilla-syncserver-docker/blob/master/LICENSE).

[Mozilla Syncserver](https://github.com/mozilla-services/syncserver) has its own license.

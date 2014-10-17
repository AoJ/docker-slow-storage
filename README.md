# Docker slow remote storage

- mount remote dir via ssh
- usefully for centralized configuration or backups
- see Makefile

## Example usage
```
FROM aooj/slow-storage
  
ENV REMOTE_HOST me@storage.server.com
ENV REMOTE_DIR /tmp/storage
ENV LOCAL_DIR /data
```
  
build it and run it!
```
docker build -t slow-storage .
docker run --cap-add mknod --cap-add sys_admin --device=/dev/fuse -v ${HOME}.ssh/id_rsa:/root/.ssh/id_rsa:ro -v ${HOME}.ssh/known_hosts:/root/.ssh/known_hosts:ro --rm -ti slow-storage
```

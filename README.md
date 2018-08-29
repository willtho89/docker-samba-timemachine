# docker-samba-timemachine
This is a simple time machine docker image using samba and avahi. It's mostly based on u/KervyN's [HowTo](https://www.reddit.com/r/homelab/comments/83vkaz/howto_make_time_machine_backups_on_a_samba/) and [dperson's](https://github.com/dperson) [Samba docker container](https://github.com/dperson/samba).

## How to use this image?

### Simple way
```
docker run -d --net=host \
            -v /opt/timemachine:/timemachine/ \
            -e TM_USER=timemachine \
            -e TM_PW=timemachine \
            --name=timemachine willtho/samba-timemachine
```

### docker-compose
Use the provided `docker-compose.yml` file and create the conainer with `docker-compose up -d`

### Environment Variables
| Varibable | Function                | Default.    |
| ----------|:-----------------------:|-------------:|
| TM_USER   | Time Machine User       | timemachine |
| TM_PW     | Users Password          | timemachine |
| TM_ID     | UserID                  | 1000        |
| TM_SIZE   | Time Machine Size in MB | 512000      |

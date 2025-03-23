FROM redis

RUN apt-get update && apt-get install -y procps

COPY ./tools/redis.conf /usr/local/etc/redis/redis.conf

CMD redis-server /usr/local/etc/redis/redis.conf

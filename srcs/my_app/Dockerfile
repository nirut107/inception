FROM debian:bullseye

RUN mkdir -p /var/www/html \
    && mkdir -p /home/store 

COPY ./local/* /home/store
COPY ./tools/script.sh ./script.sh
RUN chmod +x ./script.sh

ENTRYPOINT ["./script.sh"]

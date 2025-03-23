FROM debian:bullseye

EXPOSE 3306

RUN apt-get update -y && apt-get install mariadb-server -y

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/50-server.cnf /etc/mysql/

COPY ./tools/script.sh /

RUN chmod +x ./script.sh

WORKDIR /

CMD ["bash", "./script.sh"]

FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/ftpuser -s /bin/bash ftpuser && \
    echo "ftpuser:password" | chpasswd

COPY ./tools/vsftpd.conf /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty \
    && chown root:root /var/run/vsftpd/empty \
    && chmod 755 /var/run/vsftpd/empty
    
EXPOSE 21 21100-21110

CMD ["vsftpd", "/etc/vsftpd.conf"]

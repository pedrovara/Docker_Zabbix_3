FROM alpine

RUN apk update
RUN apk add openssh
RUN apk add lighttpd php5-common php5-iconv php5-json php5-gd php5-curl php5-xml php5-pgsql php5-imap php5-cgi fcgi
RUN apk add php5-pdo php5-pdo_pgsql php5-soap php5-xmlrpc php5-posix php5-mcrypt php5-gettext php5-ldap php5-ctype php5-dom php5-pear-mdb2-driver-mysql php5-mysqli php5-pdo_mysql php5-pear-mdb2-driver-mysqli
RUN apk add zabbix zabbix-mysql zabbix-webif zabbix-setup zabbix-doc php5-pear-mdb2-driver-mysql

RUN mkdir -p /run/lighttpd
RUN chmod 755 /run/lighttpd/
RUN chown lighttpd /run/lighttpd/

VOLUME /root/Dockerfiles/zabbix_novo/files

ADD ./files/lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD ./files/zabbix_server.conf /etc/zabbix/zabbix_server.conf
ADD ./files/php.ini /etc/php5/php.ini

COPY ./files/startup.sh /startup.sh

RUN rm /var/www/localhost/htdocs -R
RUN ln -s /usr/share/webapps/zabbix /var/www/localhost/htdocs
RUN chown -R lighttpd /usr/share/webapps/zabbix/conf

EXPOSE 80 10050 10051

CMD ["/startup.sh"]


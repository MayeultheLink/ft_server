FROM	debian:buster

RUN	apt-get -y update \
	apt-get -y install wget \
	apt-get -y install nginx \
	apt-get -y install mariadb-server \
	apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Korea/L=Seoul/O=innoaca/OU=42seoul/CN=forhjy" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
COPY ./srcs/init.sh ./
CMD bash init.sh

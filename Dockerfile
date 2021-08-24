FROM debian:buster

RUN	apt-get -y update && apt-get -y install wget \
	nginx \
	mariadb-server \
	php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
	openssl

WORKDIR	/var/www/localhost
COPY ./srcs/init.sh /var/www/

COPY ./srcs/nginx.config /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/ && \
	rm -rf /etc/nginx/sites-enabled/default

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz && \
	mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php /var/www/localhost/phpmyadmin

RUN	wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php /var/www/localhost/wordpress

RUN openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=75/L=Paris/O=42/OU=mde-la-s/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data /var/www/localhost && \
	chmod -R 755 /var/www/localhost && \
	chmod 777 /var/www/init.sh

COPY ./srcs/init.sh ./

EXPOSE 80 443

CMD bash /var/www/init.sh

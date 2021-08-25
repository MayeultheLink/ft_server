if [ $AUTOINDEX = "off" ]
then
	sed -i 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/nginx.config
fi

service mysql start

openssl req -x509 -nodes -days 365 -subj '/C=FR/ST=75/L=Paris/O=42/OU=mde-la-s/CN=localhost' -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt

echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "CREATE USER 'Mayeul'@'localhost' IDENTIFIED BY 'password';"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'Mayeul'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

service php7.3-fpm start
service nginx start

#sleep infinity & wait
bash

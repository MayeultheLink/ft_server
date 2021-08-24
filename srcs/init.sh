service mysql start

echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
#echo "CREATE USER 'Mayeul'@'localhost' IDENTIFIED BY 'password';"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

service nginx start
service php7.3-fpm start

bash

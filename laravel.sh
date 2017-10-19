# /bin/bash

sudo apt-get update && apt-get -y upgrade

echo "install dependencies..."
sudo apt-get install -y  mariadb-client mariadb-server php7.0-mcrypt php7.0-gd php7.0-mbstring php7.0-cli php7.0-xml

echo "install composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo "make a laravel app..."
cd /var/www
sudo composer create-project --prefer-dist laravel/laravel laravel
sudo chown -R www-data:www-data laravel
# make folder writable for logs...
sudo chmod -R 777 laravel/storage
cd laravel
sudo composer install
php artisan serve


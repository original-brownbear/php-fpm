cd 7.0.2
docker build -t originalbrownbear/php-fpm:7.0.2 .
cd ../5.6.17
docker build -t originalbrownbear/php-fpm:5.6.17 .
cd ..
docker push originalbrownbear/php-fpm

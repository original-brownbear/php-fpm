FROM php:7-fpm

ENV TERM linux
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get update && apt-get install -y locales curl wget curl git build-essential gnupg2 libssl-dev libffi-dev autoconf
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
   && locale-gen en_US.utf8 \
   && /usr/sbin/update-locale LANG=en_US.UTF-8

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y mysql-client libmysqlclient-dev netcat unzip \
    libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev sendmail

RUN docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mbstring 

RUN sed -i 's/^user\s.*/user = root/' /usr/local/etc/php-fpm.conf
RUN sed -i 's/^group\s.*/group = root/' /usr/local/etc/php-fpm.conf
RUN sed -i 's/^listen\s.*/listen = \/var\/run\/php\/php7-fpm.sock\nlisten.mode = 0777/' /usr/local/etc/php-fpm.conf

RUN sed -i 's/^user\s.*/user = root/' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/^group\s.*/group = root/' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/^listen\s.*/listen = \/var\/run\/php\/php7-fpm.sock\nlisten.mode = 0777/' /usr/local/etc/php-fpm.d/www.conf

RUN rm /usr/local/etc/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/www.conf.default  /usr/local/etc/php-fpm.d/zz-docker.conf 

RUN mkdir -p /var/run/php

#XDEBUG
RUN wget http://xdebug.org/files/xdebug-2.4.0rc4.tgz
RUN tar -xzf xdebug-2.4.0rc4.tgz
RUN cd xdebug* && phpize && ./configure --enable-xdebug && make && make install

COPY /conf /usr/local/etc/php

COPY run.sh /run.sh
COPY toggle-xdebug.sh /toggle-xdebug.sh
RUN chmod +x /run.sh && chmod +x /toggle-xdebug.sh
WORKDIR /

CMD ["bash", "-l", "run.sh"]

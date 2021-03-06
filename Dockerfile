FROM php:7.1-jessie

RUN apt-get update

#Install dev tools
RUN apt-get install nodejs npm git telnet mysql-client libpq-dev -y --force-yes

RUN apt-get clean && apt-get autoclean

# Lavarel requires php-zip extension
RUN apt-get install zlib1g-dev -y --force-yes
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql

RUN useradd -s /bin/bash -u 1000 -U -m user

ENV COMPOSER_ALLOW_SUPERUSER=true

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

USER 1000:1000

RUN composer global require "laravel/installer"

ENV PATH=$PATH:/home/user/.composer/vendor/bin/

RUN echo 'alias artisan="php artisan"' >> ~/.bashrc
RUN echo 'alias server="php artisan serve --host 0.0.0.0"' >> ~/.bashrc

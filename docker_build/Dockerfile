FROM debian:stretch

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    nginx \
    supervisor \
    vim \
    procps

RUN curl -sSLo /etc/apt/trusted.gpg.d/sury-php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
    php-xdebug \
    php7.1 \
    php7.1-bcmath \
    php7.1-cli \
    php7.1-curl \
    php7.1-fpm \
    php7.1-intl \
    php7.1-json \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-opcache \
    php7.1-sqlite3 \
    php7.1-xml \
    php7.1-zip \
    php7.1-redis

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHPUnit globally
RUN curl -sSLo /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/local/bin/phpunit

# Global configurations
RUN echo "America/Sao_Paulo" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata  && \
# www-data user configurations
    usermod -u 1000 www-data && \
    chsh -s /bin/bash www-data && \
    mkdir -p /var/www && \
    chown -R www-data:www-data /var/www/ && \
    chmod -R g+s /var/www && \
# Nginx configuration
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
# PHP configuration
    mkdir -p /run/php && \
    sed -i "s|;daemonize = yes|daemonize = no|"                     /etc/php/7.1/fpm/php-fpm.conf && \
    sed -i "s|;date.timezone =|date.timezone = America\/Sao_Paulo|" /etc/php/7.1/cli/php.ini && \
    sed -i "s|;date.timezone =|date.timezone = America\/Sao_Paulo|" /etc/php/7.1/fpm/php.ini && \
# Xdebug configuration
    echo "xdebug.max_nesting_level=250" >> /etc/php/7.1/mods-available/xdebug.ini && \
    echo "xdebug.remote_enable=1"       >> /etc/php/7.1/mods-available/xdebug.ini && \
    echo "xdebug.remote_handler=dbgp"   >> /etc/php/7.1/mods-available/xdebug.ini && \
    echo "xdebug.remote_mode=req"       >> /etc/php/7.1/mods-available/xdebug.ini && \
    echo "xdebug.remote_autostart=1"    >> /etc/php/7.1/mods-available/xdebug.ini && \
    echo 'xdebug.remote_host=${xdebug_remote_host}' >> /etc/php/7.1/mods-available/xdebug.ini && \
    echo 'xdebug.remote_port=${xdebug_remote_port}' >> /etc/php/7.1/mods-available/xdebug.ini

#supervisor
COPY ./config/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY ./config/localhost.conf /etc/nginx/sites-enabled/localhost.conf

#4: forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]

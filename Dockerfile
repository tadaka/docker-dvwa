FROM tutum/lamp:latest

MAINTAINER Cory Sabol <corygrandhamsabol@gmail.com>

# update sources and install php5
RUN rm -rf /app && \
    apt-get update && \
    apt-get install -y wget php5-gd unzip && \
    rm -rf /var/lib/apt/lists/*

#WORKDIR /var/www/html/

# get DVWA
RUN wget https://github.com/ethicalhack3r/DVWA/archive/master.zip && \
    unzip master.zip && \
    mkdir app && \
    cp -r DVWA-master/* /app && \
    rm -rf DVWA-master DVWA-master.zip && \
    chmod +777 ./app/hackable/uploads/ && \
    chmod +777 ./app/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt && \
    sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php5/apache2/php.ini && \
    sed -i "s/$_DVWA[ 'recaptcha_private_key' ] = ''/$_DVWA[ 'recaptcha_private_key' ] = 'TaQ185RFuWM'/g" /app/config/config.inc.php.dist && \
    sed -i "s/$_DVWA[ 'recaptcha_public_key' ] = ''/$_DVWA[ 'recaptcha_public_key' ] = 'TaQ185RFuWM'/g" /app/config/config.inc.php.dist && \
    sed -i 's/FileInfo/All/g' /etc/apache2/sites-available/000-default.conf && \
    sed -i 's/root/admin/g' /app/config/config.inc.php.dist && \
    echo "sed -i \"s/p@ssw0rd/\$PASS/g\" /app/config/config.inc.php.dist" >> /create_mysql_admin_user.sh && \
    echo 'session.save_path = "/tmp"' >> /etc/php5/apache2/php.ini

RUN ls -a 

EXPOSE 80 3306

CMD ["/run.sh"]

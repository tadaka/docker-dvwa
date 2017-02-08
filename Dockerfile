from ubuntu

# update the sources
RUN apt-get update
# install the stuff needed to run dvwa
RUN apt-get -y install apache2 mysql-server php5 php5-mysql php5-gd

# set the working dir
WORKDIR /var/www/html/
# Bundle the app
COPY ./dvwa/* /var/www/html/

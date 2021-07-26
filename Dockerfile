FROM ubuntu:20.04


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt update && apt upgrade -y
RUN apt install tzdata -y
RUN apt install libapache2-mod-php7.4 -y
RUN apt install -y php7.4-curl php7.4-gd php7.4-json php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-xmlrpc php7.4-intl php7.4-mbstring php7.4-soap php7.4-zip
ADD https://download.moodle.org/moodle/moodle-latest.tgz /var/www/moodle-latest.tgz
RUN cd /var/www && rm /var/www/html/* && tar -zxf ./moodle-latest.tgz && mv ./moodle/ ./html -T
RUN chown -R www-data:www-data /var/www/html
RUN mkdir /var/moodledata
RUN chown -R www-data:www-data /var/moodledata && chmod 700 /var/moodledata
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND

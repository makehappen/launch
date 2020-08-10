#!/bin/sh

# call script with
# IMAGE_IP=... && AWS_IMAGE_CONFIG=... && . src/image/build.sh

. aws/images/config/$AWS_IMAGE_CONFIG.sh

# install
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get update; sudo apt-get upgrade -y;"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install apache2 libapache2-mod-wsgi python-dev -y;"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install -y --no-install-recommends libfreetype6-dev apt-utils;"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install software-properties-common -y"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "export DEBIAN_FRONTEND=\"noninteractive\""
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install php -y;"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install php-cli php-common -y"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install -y php-pear php-curl php-dev php-gd php-mbstring php-zip php-mysql php-xml php-fpm libapache2-mod-php php-imagick php-tidy php-xmlrpc php-bcmath php-intl"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install -y mysql-client zip unzip git nano tree vim curl mcrypt sqlite3"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "curl -s https://getcomposer.org/installer | php"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo mv composer.phar /usr/local/bin/composer"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get remove -y javascript-common"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo apt-get install -y supervisor"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo service php7.4-fpm restart"

scp -i $AWS_PEM_KEY_PATH src/image/templates/apache2/apache2.conf ubuntu@$IMAGE_IP:~/
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo mv ~/apache2.conf /etc/apache2/apache2.conf"

ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo sudo a2enmod expires mime deflate rewrite headers vhost_alias php7.4"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo systemctl restart apache2"

ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo rm /etc/apache2/sites-enabled/000-default.conf"

scp -i $AWS_PEM_KEY_PATH src/image/templates/apache2/1.4-levels.conf ubuntu@$IMAGE_IP:~/
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo mv ~/1.4-levels.conf /etc/apache2/sites-available/1.4-levels.conf"

scp -i $AWS_PEM_KEY_PATH src/image/templates/apache2/2.3-levels.conf ubuntu@$IMAGE_IP:~/
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo mv ~/2.3-levels.conf /etc/apache2/sites-available/2.3-levels.conf"

scp -i $AWS_PEM_KEY_PATH src/image/templates/apache2/3.2-levels.conf ubuntu@$IMAGE_IP:~/
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo mv ~/3.2-levels.conf /etc/apache2/sites-available/3.2-levels.conf"

ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo a2ensite 1.4-levels"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo a2ensite 2.3-levels"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo a2ensite 3.2-levels"

ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo service apache2 reload"

ssh -i $AWS_PEM_KEY_PATH ubuntu@$IMAGE_IP "sudo chown -R ubuntu:ubuntu /var/www/"

scp -i $AWS_PEM_KEY_PATH src/image/templates/www/.htaccess ubuntu@$IMAGE_IP:/var/www
scp -i $AWS_PEM_KEY_PATH src/image/templates/.ssh/config ubuntu@$IMAGE_IP:~/.ssh/

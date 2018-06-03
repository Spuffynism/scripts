if [[ $# -eq 0 ]] ; then
    echo 'You must specify a valid virtual host name'
    exit 0
fi

vhost=$1
export vhost

sudo mkdir -p /var/www/"$vhost"
sudo chmod -R 777 /var/www/"$vhost"
sudo -E bash -c 'echo -e "<?php phpinfo();" > /var/www/$vhost/index.php'
sudo -E bash -c 'echo -e "<VirtualHost *:80>
    ServerAdmin admin@$vhost
    ServerName $vhost
    ServerAlias www.$vhost
    DocumentRoot /var/www/$vhost
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/$vhost.conf'
sudo a2ensite "$vhost".conf
sudo service apache2 restart
sudo -E bash -c 'echo -e "127.0.0.1 $vhost" >> /etc/hosts'
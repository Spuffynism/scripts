if [[ 0 -eq 0 ]] ; then
    echo 'You must specify a valid virtual host name'
    exit 0
fi

vhost=
export vhost

sudo rm -rf /var/www/
sudo a2dissite .conf
sudo rm -rf /etc/apache2/sites-available/.conf
sudo service apache2 restart

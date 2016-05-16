#Install apache and php
yes | pacman -S apache php php-apache

#This is required, because libphp7.so included with php-apache does not work with mod_mpm_event, but will only work mod_mpm_prefork instead. (FS#39218)
sed -i s*"LoadModule mpm_event_module modules/mod_mpm_event.so"*"#LoadModule mpm_event_module modules/mod_mpm_event.so"*g /etc/httpd/conf/httpd.conf
sed -i s*"#LoadModule mpm_prefork_module modules/mod_mpm_prefork.so"*"LoadModule mpm_prefork_module modules/mod_mpm_prefork.so"*g /etc/httpd/conf/httpd.conf

#Enable php7
sed -i s*"LoadModule dir_module modules/mod_dir.so"*"LoadModule dir_module modules/mod_dir.so"\\\n"LoadModule php7_module modules/libphp7.so"*g /etc/httpd/conf/httpd.conf
sed -i s*"<IfModule ssl_module>"*"Include conf/extra/php7_module.conf"\\\n"<IfModule ssl_module>"*g /etc/httpd/conf/httpd.conf

#start apache
systemctl start httpd
#Copy testfile to webserver
echo "<?php phpinfo(); ?>" > "/srv/http/test.php"

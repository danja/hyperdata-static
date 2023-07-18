

mv /opt/lampp/etc/extra/httpd-vhosts.conf /opt/lampp/etc/extra/httpd-vhosts.conf_
cp httpd-vhosts.conf /opt/lampp/etc/extra/httpd-vhosts.conf
chown daemon:root /opt/lampp/etc/extra/httpd-vhosts.conf
chmod 755 /opt/lampp/etc/extra/httpd-vhosts.conf 

mv /opt/lampp/etc/httpd.conf /opt/lampp/etc/httpd.conf_
cp httpd.conf /opt/lampp/etc/httpd.conf
chown daemon:root /opt/lampp/etc/httpd.conf
chmod 755 /opt/lampp/etc/httpd.conf

mv /opt/lampp/etc/httpd-subdomains.conf /opt/lampp/etc/httpd-subdomains.conf_
cp httpd-subdomains.conf /opt/lampp/etc/httpd-subdomains.conf
chown daemon:root /opt/lampp/etc/httpd-subdomains.conf
chmod 755 /opt/lampp/etc/httpd-subdomains.conf



mv /opt/lampp/etc/extra/httpd-dav.conf /opt/lampp/etc/extra/httpd-dav.conf_
cp httpd-dav.conf /opt/lampp/etc/extra/httpd-dav.conf 
chown daemon:root /opt/lampp/etc/extra/httpd-dav.conf 
chmod 755 /opt/lampp/etc/extra/httpd-dav.conf 

# /opt/lampp/etc/extra/httpd-ssl.conf
# /etc/apache2/ports.conf
# I HAVE REMOVED REDIRECTS FROM 
# /opt/lampp/etc/extra/httpd-vhosts.conf


# -rwxr-xr-x 1 daemon root
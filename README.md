# nginx-ldap
Dockerfile and nginx.conf for basic NGINX installation on Ubuntu with LDAP support.

LDAP support added from:
https://github.com/kvspb/nginx-auth-ldap

    docker run --rm \
      -v /srv/my_site.conf:/etc/nginx/sites/my_site.conf \
      -v /srv/my_ldap.conf:/etc/nginx/conf.d/my_site.conf \
      jgriffiths1993/nginx-ldap
      

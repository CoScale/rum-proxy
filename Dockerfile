FROM ubuntu:16.04

MAINTAINER pvh <peter.van.hertum@coscale.com>

# EXPOSE THE PORTS
EXPOSE 80 443

# COPY THE EXTRA FILES
ADD extra/entrypoint.sh extra/rumrevproxy.conf extra/rumrevproxy-ssl.conf /

# INSTALL APACHE
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 && \
# ENABLE THE NECESSARY MODULES
    a2enmod xml2enc && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    a2enmod proxy_ajp && \
    a2enmod rewrite && \
    a2enmod deflate && \
    a2enmod headers && \
    a2enmod proxy_balancer && \
    a2enmod proxy_connect && \
    a2enmod proxy_html && \
    a2enmod ssl && \
# INSTALL THE SITES
    mv /rumrevproxy.conf /etc/apache2/sites-available/rumrevproxy.conf && \
    mv /rumrevproxy-ssl.conf /etc/apache2/sites-available/rumrevproxy-ssl.conf && \
# ENABLE THE NO-SSL SITE AND DISABLE THE DEFAULT SITE
    a2ensite rumrevproxy && \
    a2dissite 000-default && \
# CLEANUP
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SET THE ENTRYPOINT THAT SETS THE VARIABLE OPTIONS AND RUNS THE PROCESS
CMD /entrypoint.sh

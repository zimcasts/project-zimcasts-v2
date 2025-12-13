# Use minimal Ubuntu as base
FROM ubuntu:latest

# Install Nginx
RUN apt-get update -y && apt-get install -y nginx

# COPY HTTP server settings
COPY ./zimcasts-web/sites-available/zimcasts-web /etc/nginx/sites-available

# COPY SAMPLE HTML FILE
COPY ./zimcasts-web/html/ /var/www/zimcasts-web/html/

# ENABLE THE HTTP SERVER BASED FROM THE HTTP SERVER SETTINGS COPIED
RUN ln -s /etc/nginx/sites-available/zimcasts-web /etc/nginx/sites-enabled/zimcasts-web

# EXPOSE AND ENABLE PORT 8000
EXPOSE 8000


# Run the Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
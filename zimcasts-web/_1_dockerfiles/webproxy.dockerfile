# Use minimal Ubuntu as base
FROM ubuntu:latest

# Install Nginx
RUN apt-get update -y && apt-get install -y nginx

# COPY PROXY server settings
COPY ./zimcasts-web/conf.d/zimcasts-web.conf /etc/nginx/conf.d/zimcasts-web.conf


# EXPOSE AND ENABLE PORT 8000
EXPOSE 8000


# Run the Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
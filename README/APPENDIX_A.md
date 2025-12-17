# Appendix A: Web App Dockerfile

This Dockerfile builds a lightweight **Ubuntu-based container** with **Nginx** installed to serve the web application.  
It copies the necessary configuration and HTML files, enables the site, and exposes **port 8000**.

---

## 📄 webapp.dockerfile

```dockerfile
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
```

---

## 🔑 Notes

- **Base Image**: Uses `ubuntu:latest` for a minimal environment.  
- **Nginx Installation**: Installs Nginx via `apt-get`.  
- **Configuration**: Copies custom Nginx site configuration from `zimcasts-web/sites-available`.  
- **HTML Content**: Copies sample HTML files into `/var/www/zimcasts-web/html/`.  
- **Site Enablement**: Creates a symbolic link in `sites-enabled` to activate the site.  
- **Port Exposure**: Exposes **port 8000** for serving the application.  
- **Startup Command**: Runs Nginx in the foreground using `CMD`.  
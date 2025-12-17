# Appendix B: Web Proxy Dockerfile

This Dockerfile builds a lightweight **Ubuntu-based container** with **Nginx** installed to act as a **reverse proxy**.  
It copies the necessary proxy configuration file, exposes **port 8000**, and runs Nginx in the foreground.

---

## 📄 webproxy.dockerfile

```dockerfile
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
```

---

## 🔎 Service Summary Table

| **Instruction** | **Purpose** | **Details** |
|---------------------|-----------------|-----------------|
| `FROM ubuntu:latest` | Base image | Uses minimal Ubuntu environment |
| `RUN apt-get update -y && apt-get install -y nginx` | Install Nginx | Ensures proxy server is available |
| `COPY ./zimcasts-web/conf.d/zimcasts-web.conf /etc/nginx/conf.d/zimcasts-web.conf` | Copy config | Adds custom Nginx proxy configuration |
| `EXPOSE 8000` | Port exposure | Makes port 8000 available for traffic |
| `CMD ["/usr/sbin/nginx", "-g", "daemon off;"]` | Startup command | Runs Nginx in foreground mode |

---

## 🔑 Notes

- **Base Image**: Uses `ubuntu:latest` for a minimal environment.  
- **Nginx Installation**: Installs Nginx via `apt-get`.  
- **Configuration**: Copies proxy server settings from `zimcasts-web/conf.d/zimcasts-web.conf`.  
- **Port Exposure**: Exposes **port 8000** for proxy traffic.  
- **Startup Command**: Runs Nginx in the foreground using `CMD`.  
# Appendix C: NGINX Web App Configuration

This appendix contains the **HTML file** and **NGINX configuration files** used to serve the web application and configure the reverse proxy for load balancing.

---

## 📄 index.html

```html
<!DOCTYPE html>
<head>
    <title>Welcome to Test Website!</title>
</head>
<body>
    <h1>HELLO WORLD from ZIMCASTS</h1>
</body>
</html>
```

---

## 📄 sites-available/zimcasts-web

```nginx
server {
    listen 8000 default_server;
    listen [::]:8000 default_server;
    
    root /var/www/zimcasts-web/html;
    index index.html index.htm;

    server_name _;
    location / {
        try_files $uri $uri/ =404;
    }
}
```

---

## 📄 conf.d/zimcasts-web.conf

```nginx
upstream backend {
    server webapp1:8000;
    server webapp2:8000;
    server webapp3:8000;
}
server {
    listen 8000;
    location / {
        proxy_pass http://backend;
    }
}
```

---

## 🔎 Configuration Summary Table

| **File** | **Purpose** | **Key Details** |
|--------------|-----------------|---------------------|
| `index.html` | Sample HTML page | Displays "HELLO WORLD from ZIMCASTS" |
| `sites-available/zimcasts-web` | Web app server config | Serves static HTML files on port 8000 |
| `conf.d/zimcasts-web.conf` | Reverse proxy config | Load balances requests across `webapp1`, `webapp2`, `webapp3` |

---

## 🔑 Notes

- **index.html** provides a simple test page to verify the web server setup.  
- **sites-available/zimcasts-web** defines the NGINX server block for serving static content.  
- **conf.d/zimcasts-web.conf** configures the reverse proxy and load balancing using the `upstream` directive.  
- Together, these files enable both **direct serving of static content** and **proxying requests to multiple app containers**.  

---

## References

<https://www.baeldung.com/linux/nginx-docker-container>  
Microsoft Copilot for Load Balancer and Proxy setup  
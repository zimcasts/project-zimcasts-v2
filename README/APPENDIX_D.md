# Appendix D: Docker Compose YAML File for Web App and Web Proxy

This appendix defines the **Docker Compose YAML file** used to build and run the **Web App** and **Web Proxy** containers.  
It ensures that multiple web app instances are connected to a reverse proxy for load balancing.

---

## 📄 docker-compose.yml

```yaml
services:

  appimg:
    build:
      context: .
      dockerfile: ./zimcasts-web/_dockerfiles/webapp.dockerfile
      tags:
        - webapp-image

  proxyimg:
    build:
      context: .
      dockerfile: ./zimcasts-web/_dockerfiles/webproxy.dockerfile
      tags:
        - webproxy-image

  webapp1:
    image: webapp-image
    hostname: webapp1
    networks:
      - test-network

  webapp2:
    image: webapp-image
    hostname: webapp2
    networks:
      - test-network

  webapp3:
    image: webapp-image
    hostname: webapp3
    networks:
      - test-network
      
  webproxy:
    image: webproxy-image
    hostname: webproxy
    ports:
      - 8000:8000
    networks:
      - test-network
    depends_on:
      - webapp1
      - webapp2
      - webapp3

networks:
  test-network:
    driver: bridge
```

---

## 🔎 Service Summary Table

| **Service** | **Role** | **Key Configurations** |
|-----------------|--------------|-----------------------------|
| `appimg`      | Build image for web app | Uses `webapp.dockerfile`, tagged as `webapp-image` |
| `proxyimg`    | Build image for reverse proxy | Uses `webproxy.dockerfile`, tagged as `webproxy-image` |
| `webapp1`     | Web app container instance | Image: `webapp-image`, Hostname: `webapp1`, Network: `test-network` |
| `webapp2`     | Web app container instance | Image: `webapp-image`, Hostname: `webapp2`, Network: `test-network` |
| `webapp3`     | Web app container instance | Image: `webapp-image`, Hostname: `webapp3`, Network: `test-network` |
| `webproxy`    | Reverse proxy container | Image: `webproxy-image`, Hostname: `webproxy`, Port: `8000:8000`, Depends on: `webapp1-3` |

---

## 📊 Diagram (ASCII Representation)

```
                 +-------------------+
                 |   webproxy        |
                 | (Reverse Proxy)   |
                 +---------+---------+
                           |
          ---------------------------------
          |               |               |
   +------+-----+   +-----+------+   +-----+------+
   |  webapp1   |   |  webapp2   |   |  webapp3   |
   | (App Img)  |   | (App Img)  |   | (App Img)  |
   +------------+   +------------+   +------------+
```

---

## 🔑 Notes

- **appimg** and **proxyimg** build the base images for the web app and proxy.  
- **webapp1**, **webapp2**, and **webapp3** are identical containers running the web app.  
- **webproxy** acts as a reverse proxy, distributing traffic across the three web app containers.  
- All services are connected to the same **test-network** for internal communication.  
- The **bridge driver** is used to create an isolated Docker network.  
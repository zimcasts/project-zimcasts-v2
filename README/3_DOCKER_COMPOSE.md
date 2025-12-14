# Run Multiple Container Instances Using Docker Compose

Docker Compose is used to run multiple **containers** for simplified management of the interconnected **services**.

The **docker-compose.yml** file is essential to run and manage multiple **Docker containers**.

We can apply what we have created in **Part 1** and **Part 2** in the **docker-compose.yml** file.

---

## docker-compose.yml

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

## 🔎 Service Summary

| **Service** | **Role** | **Key Configurations** |
|-----------------|--------------|-----------------------------|
| `appimg`        | Build image for web app | Uses `webapp.dockerfile`, tagged as `webapp-image` |
| `proxyimg`      | Build image for reverse proxy | Uses `webproxy.dockerfile`, tagged as `webproxy-image` |
| `webapp1`       | Web app container instance | Image: `webapp-image`, Hostname: `webapp1`, Network: `test-network` |
| `webapp2`       | Web app container instance | Image: `webapp-image`, Hostname: `webapp2`, Network: `test-network` |
| `webapp3`       | Web app container instance | Image: `webapp-image`, Hostname: `webapp3`, Network: `test-network` |
| `webproxy`      | Reverse proxy container | Image: `webproxy-image`, Hostname: `webproxy`, Port: `8000:8000`, Depends on: `webapp1-3` |

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

Once the **YAML file** is saved, execute the following command to setup **Web App** with **Proxy** and **Load Balancing** feature:

**SYNTAX:**
```bash
docker-compose up -d --build
```

---

If you wish to **remove** these **services** built by **Docker Compose**, execute the following:

**SYNTAX:**
```bash
docker-compose down
```

---

## 🔑 Notes

- **Docker Compose** simplifies running multiple containers by defining them in a single **YAML file**.  
- It allows you to manage **networks**, **dependencies**, and **ports** without manually running multiple commands.  
- Scaling services is easier — you can add more instances by adjusting the **docker-compose.yml** file.  
- For production environments, consider using **Docker Swarm** or **Kubernetes** for advanced orchestration and built-in load balancing.  


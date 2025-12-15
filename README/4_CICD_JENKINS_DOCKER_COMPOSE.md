# 4. Setting Up CI/CD using Jenkins

We will update the **docker-compose.yml** file we previously created in **Part 3: Run Multiple Container Instances Using Docker Compose** and add another container instance for **Jenkins**.  
This container will be used for **Continuous Integration / Continuous Deployment (CI/CD)**.

For creating a **Jenkins container**, please refer to the link at the bottom of this page.

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

  jenkins_cicd_server:
    image: jenkins/jenkins:lts-jdk21
    hostname: jenkins_svr
    ports:
      - 8080:8080
      - 50000:50000
    networks:
      - test-network
    volumes:
      - jenkins_home:/var/jenkins_home
    restart: on-failure

networks:
  test-network:
    driver: bridge

volumes:
  jenkins_home:
```

---

## 🔎 Service Summary

| **Service**          | **Role**                        | **Key Configurations** |
|--------------------------|-------------------------------------|-----------------------------|
| `appimg`               | Build image for web app             | Uses `webapp.dockerfile`, tagged as `webapp-image` |
| `proxyimg`             | Build image for reverse proxy       | Uses `webproxy.dockerfile`, tagged as `webproxy-image` |
| `webapp1`              | Web app container instance          | Image: `webapp-image`, Hostname: `webapp1`, Network: `test-network` |
| `webapp2`              | Web app container instance          | Image: `webapp-image`, Hostname: `webapp2`, Network: `test-network` |
| `webapp3`              | Web app container instance          | Image: `webapp-image`, Hostname: `webapp3`, Network: `test-network` |
| `webproxy`             | Reverse proxy container             | Image: `webproxy-image`, Hostname: `webproxy`, Port: `8000:8000`, Depends on: `webapp1-3` |
| `jenkins_cicd_server` | Jenkins CI/CD server container      | Image: `jenkins/jenkins:lts-jdk21`, Hostname: `jenkins_svr`, Ports: `8080`, `50000`, Volume: `jenkins_home` |

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

                 +-------------------+
                 |   Jenkins CI/CD   |
                 |   jenkins_svr     |
                 +-------------------+
                           |
                     (Connected to test-network)
```

---

Once the **YAML file** is saved, execute the following command:

**SYNTAX:**
```bash
docker-compose up -d --build
```

---

To get the **Initial Admin Password** of the **Jenkins container**, you can check the logs by using this command:

**SYNTAX:**
```bash
docker logs <container name>
```

---

## 🔑 Notes

- Adding **Jenkins** integrates **CI/CD** capabilities into your Docker Compose setup.  
- The **jenkins_home volume** ensures persistence of Jenkins configuration and job data.  
- Ports **8080** (web interface) and **50000** (agent communication) are exposed for Jenkins usage.  
- Restart policy set to **on-failure** ensures Jenkins will automatically restart if it crashes.  

---

## References

<https://github.com/jenkinsci/docker>
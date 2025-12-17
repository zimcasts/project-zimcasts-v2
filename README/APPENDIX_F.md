# Appendix F: Jenkins Docker Compose YAML File

This appendix defines the **Docker Compose YAML file** used to build and run the **Jenkins CI/CD server** with Docker installed.  
It ensures Jenkins is connected to the same network as other services and persists data using a Docker volume.

---

## 📄 jenkins-docker-setup.yml

```yaml
services:
  jenkinsimg:
    build:
      context: .
      dockerfile: ./zimcasts-web/_dockerfiles/jenkins.dockerfile
      tags:
        - testjenkins-image

  jenkins_cicd_server:
    image: testjenkins-image
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

## 🔎 Service Summary Table

| **Service**          | **Role**                  | **Key Configurations** |
|--------------------------|-------------------------------|-----------------------------|
| `jenkinsimg`           | Build Jenkins image           | Uses `jenkins.dockerfile`, tagged as `testjenkins-image` |
| `jenkins_cicd_server` | Jenkins CI/CD server container | Image: `testjenkins-image`, Hostname: `jenkins_svr`, Ports: `8080`, `50000`, Volume: `jenkins_home`, Restart policy: `on-failure` |
| `test-network`         | Docker network                | Driver: `bridge` |
| `jenkins_home`        | Docker volume                 | Persists Jenkins configuration and job data |

---

## 📊 Diagram (ASCII Representation)

```
                          +----------------------+
                          |   Jenkins CI/CD      |
                          |   jenkins_svr        |
                          |   Docker Installed   |
                          |   Ports: 8080, 50000 |
                          +----------+-----------+
                                     |
                            (Connected to test-network)
                                     |
         -----------------------------------------------------
         |                                                   |
+-------------------+                               +-------------------+
|   webproxy        |                               |   jenkins_home    |
| (Reverse Proxy)   |                               | Persistent Volume |
| Ports: 8000       |                               | Jenkins Data      |
+---------+---------+                               +-------------------+
          |
          v
  -------------------------------
  |             |               |
+------+-----+  +-----+------+  +-----+------+
| webapp1    |  | webapp2    |  | webapp3    |
| (App Img)  |  | (App Img)  |  | (App Img)  |
| Serves     |  | Serves     |  | Serves     |
| index.html |  | index.html |  | index.html |
+------------+  +------------+  +------------+
```



---

## 🔑 Notes

- **jenkinsimg** builds a custom Jenkins image with Docker installed.  
- **jenkins_cicd_server** runs Jenkins, exposing **port 8080** for the UI and **port 50000** for agent communication.  
- **jenkins_home volume** ensures Jenkins data (jobs, configs, plugins) is persisted across container restarts.  
- **test-network** connects Jenkins to other containers for CI/CD integration.  
- Restart policy set to **on-failure** ensures Jenkins automatically recovers if it crashes.  
- **webproxy**: Acts as reverse proxy, routing traffic to multiple web app containers.  
- **webapp1, webapp2, webapp3**: Serve static content (`index.html`) and are load-balanced by the proxy.  


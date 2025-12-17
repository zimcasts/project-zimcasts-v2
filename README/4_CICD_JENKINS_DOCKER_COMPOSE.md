# 4. Setting Up CI/CD Using Jenkins

We will create a separate **Jenkins Dockerfile** and **Docker Compose YAML file**.  
This will create a **Docker image** and **container** that has Jenkins and Docker installed.

Check the **Appendix section** of the README to get information on the declarative structure of **Dockerfiles** and **NGINX configuration files**.

---

## 📋 Pre-requisites

- Web App Dockerfile (**Appendix A**)  
- Web Proxy Dockerfile (**Appendix B**)  
- NGINX configuration files and Test HTML file (**Appendix C**)  
- docker-compose.yml (**Appendix D**)  

---

## 📁 Files and Folders Structure

```
ZIMCASTS/
├── README/
│   ├── 1_WEBAPP.md
│   ├── 2_PROXY_LB_SETUP.md
│   ├── 3_DOCKER_COMPOSE.md
│   └── 4_CICD_JENKINS_DOCKER_COMPOSE.md
├── zimcasts-web/
│   ├── _dockerfiles/
│   │   ├── webapp.dockerfile
│   │   └── webproxy.dockerfile
│   ├── conf.d/
│   │   └── zimcasts-web.conf
│   ├── html/
│   │   └── index.html
│   └── sites-available/
│       └── zimcasts-web
└── docker-compose.yml
```

---

## 🛠 Instructions

1. **Create Jenkins Dockerfile**  
   Please refer to **Appendix E: Jenkins Dockerfile** in the README section.  

2. **Create a custom Docker Compose YAML file**  
   This will build and run the **Jenkins Server** with Docker installed.  
   Refer to **Appendix F: Jenkins Docker Compose YAML file**.  

3. **Build the Jenkins environment**  
   Execute the following command:  

   **SYNTAX:**  
   ```bash
   docker-compose -f <custom docker compose filename> up -d --build
   ```

4. **Clean up the Jenkins environment**  
   Run this command below:  

   **SYNTAX:**  
   ```bash
   docker-compose -f <custom docker compose filename> down
   ```

---

## 🔑 Notes

- Jenkins provides a powerful way to integrate **CI/CD pipelines** into your Dockerized environment.  
- Using a **separate Dockerfile** ensures Jenkins has Docker installed and ready for builds.  
- The **custom Docker Compose file** isolates Jenkins from other services while keeping it on the same network.  
- Always check the **Appendix** for declarative structures and configuration references.  
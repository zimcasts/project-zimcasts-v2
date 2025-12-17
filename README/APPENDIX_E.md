# Appendix E: Jenkins Dockerfile

## 🎯 Objective  
Create a **Jenkins container** with **Docker installed** to enable CI/CD pipelines.

---

## 📄 jenkins.dockerfile

```dockerfile
# Objective: create jenkins container with docker installed

# Pull jenkins image from Docker hub
FROM jenkins/jenkins:lts-jdk21

# Set work directory context
WORKDIR /tmp/zimcasts

# Copy files and folders in the jenkins container
COPY ./README .
COPY ./zimcasts-web .
COPY ./docker-compose.yml .

# Switch to root user to install docker
USER root

# INSTALL DOCKER SECTION
# Update package index and install required tools (for HTTPS repositories):
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg

# Set up the Docker apt repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine and related tools:
RUN apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Expose ports for jenkins service and accessing GUI
EXPOSE 8080
EXPOSE 50000

# Switch back to jenkins_home directory
WORKDIR /var/jenkins_home

# Switch back to jenkins user - best practice
USER jenkins
```

---

## 🔎 Service Summary Table

| **Instruction** | **Purpose** | **Details** |
|---------------------|-----------------|-----------------|
| `FROM jenkins/jenkins:lts-jdk21` | Base image | Pulls Jenkins LTS image with JDK 21 |
| `WORKDIR /tmp/zimcasts` | Working directory | Sets temporary context for file operations |
| `COPY ./README ./zimcasts-web ./docker-compose.yml` | Copy files | Makes project files available inside container |
| `USER root` | Switch user | Grants root privileges for Docker installation |
| `RUN apt-get update && apt-get install -y ...` | Install dependencies | Adds required tools for HTTPS repositories |
| `RUN curl -fsSL ... gpg` | Add GPG key | Ensures Docker packages are verified |
| `RUN echo "deb ..." | Add Docker repo | Configures apt to use Docker’s repository |
| `RUN apt-get install docker-ce ...` | Install Docker Engine | Installs Docker and related CLI tools |
| `EXPOSE 8080, 50000` | Ports | Opens Jenkins web UI (8080) and agent communication (50000) |
| `WORKDIR /var/jenkins_home` | Jenkins home | Sets working directory back to Jenkins home |
| `USER jenkins` | Best practice | Switches back to Jenkins user for security |

---

## 🔑 Notes

- This Dockerfile extends the official **Jenkins LTS image** and installs **Docker Engine**.  
- Exposes **port 8080** for Jenkins UI and **port 50000** for agent connections.  
- Copies project files (`README`, `zimcasts-web`, `docker-compose.yml`) into the container for CI/CD usage.  
- Uses **root privileges temporarily** to install Docker, then switches back to the **jenkins user** for best practice.  
- Ensures Jenkins can run pipelines that build and deploy Docker containers.  

---

## References

<https://www.bing.com/search?pglt=297&q=install+docker+debian&cvid=bfffbdf8fbf046caa0ca1156d49e2274&gs_lcrp=EgRlZGdlKgYIABBFGDkyBggAEEUYOTIGCAEQABhAMgYIAhAAGEAyBggDEAAYQDIGCAQQABhAMgYIBRAAGEAyBggGEAAYQDIGCAcQABhAMgYICBAAGEDSAQg1Nzk0ajBqMagCALACAA&FORM=ANNTA1&adppc=EDGEESS&PC=U531>  
<https://docs.docker.com/engine/install/debian/>  
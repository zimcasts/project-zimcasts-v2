# Configure a Simple Web Server That Handles a Single HTML Page (Nginx)

## NGINX

1. **Prepare** or **create** your own `index.html` page, which serves as the **homepage** of the sample web server.  

2. **Configure** the web server that will be hosted on **Nginx**.  


## DOCKER

1. **Create** a **Dockerfile** to make a template for the test **Nginx** server.  
   The following **instructions/commands** are used to make the **image** of the web server:

   | **Command** | **Description** |
   |-------------|-----------------|
   | `FROM`      | Create a new build stage from a base image. |
   | `COPY`      | Copy files and directories. |
   | `RUN`       | Execute build commands. |
   | `EXPOSE`    | Describe which ports your application is listening on. |
   | `CMD`       | Specify default commands. |

---

2. **Build** the **image** based on the **Dockerfile** by using the **docker build** command.  

   **SYNTAX:**  
   ```bash
   docker build -t <image name> .

---

3. **Run** a **Docker container** based on the **image** created in step 2.  
The following **options and arguments** will be used:

| **Option/Argument** | **Description** |
|----------------------|-----------------|
| `-p`                | Port number is **8000** |
| `-it`               | Access the container **interactively** (terminal); useful for **troubleshooting** |
| `-d`                | **Detach mode**. Allows executing Docker commands in the same terminal |
| `--name`            | *(Optional)* Name of the container |
| `-h`                | *(Optional)* Set a **hostname** in the container |
| `<Image name>`      | *(Mandatory)* Run a container based on the image you created |

**SYNTAX:**  
```bash
docker run -p 8000 -it -d --name <container name> -h <hostname of the container> <image name>


---

4. In your **web browser**, type: http://localhost:8000 to **verify** if the website is **up and running**.  




## REFERENCES

- https://www.baeldung.com/linux/nginx-docker-container  
- https://docs.docker.com/reference/dockerfile/



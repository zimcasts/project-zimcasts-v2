# 2. Setup Reverse Proxy and Load Balancer

## 🛠 Step 1: Create a Docker Network

You’ll want all **containers** (including the **reverse proxy**) to communicate on the same **user-defined network**.

**SYNTAX:**
```bash
docker network create <network name>
```

---

## 🛠 Step 2: Create Multiple App Containers

Assume your custom **Nginx container image** is based on **Part 1: Configure a Simple Web Server That Handles a Single HTML Page (Nginx).**

Each **container** will expose **port 8000** internally, but you don’t need to map them to host ports because the **reverse proxy** will handle traffic.  
Then **attach** your containers:

**SYNTAX:**
```bash
docker run -d --name app1 --network <network name> <image name>
docker run -d --name app2 --network <network name> <image name>
docker run -d --name app3 --network <network name> <image name>
```

---

## 🛠 Step 3: Configure Nginx Reverse Proxy

Create a new **Nginx container** that acts as the **load balancer**.  
You’ll need a custom **nginx.conf** like below and save it to:  
`/etc/nginx/conf.d/<custom nginx filename>.conf`

```nginx
upstream backend {
    server app1:8000;
    server app2:8000;
    server app3:8000;
}

server {
    listen 8000;
    location / {
        proxy_pass http://backend;
    }
}
```

Notice how the **upstream block** points to the **container names** (`app1`, `app2`, `app3`) — Docker’s **internal DNS** resolves these automatically when they’re on the same **network**.

---

## 🛠 Step 4: Run the Reverse Proxy Container

Mount your **custom config** into the **reverse proxy container**:

```bash
docker run -d --name nginx-proxy 
  --network <network name> 
  -p 8000:8000 
  -v "<host folder location of custom nginx.conf file>:/etc/nginx/conf.d/<custom nginx filename>.conf:ro" 
  nginx
```

Now, requests to `http://localhost:8000` will be **distributed** across your three **app containers**.

---

## 🛠 Step 5: Test Load Balancing

Open your **browser** or use **curl**:

**SYNTAX:**
```bash
curl http://localhost:8000
```

Refresh multiple times — you should see **responses alternating** between your **app containers** (depending on what they serve).  

You can **edit** the `html` files of the **web app containers** manually to **differentiate** and **verify** that the **load balancing** is working fine.

---

## 🔑 Notes

- By default, **Nginx** uses **round-robin load balancing**. You can configure other strategies like `least_conn` or `ip_hash`.  
- For **production**, you might want to use **Docker Compose** to define all **services** and **networks** in one **YAML file**.  
- If you plan to **scale dynamically**, tools like **Docker Swarm** or **Kubernetes** provide built-in **service discovery** and **load balancing**.  
#Objective: create jenkins container with docker installed


# Pull jenkins image from Docker hub
FROM jenkins/jenkins:lts-jdk21

# Set work directory context
WORKDIR /tmp/zimcasts

# Copy files and folders in the jenkins container
COPY ./README .
COPY ./zimcasts-web .
COPY ./docker-compose.yml .

# Switch to root user to install docker / packages
USER root

# INSTALL DOCKER SECTION

# Update package index and install required tools (for HTTPS repositories):
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release sudo


# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg

# Set up the Docker apt repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine and related tools:
RUN apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add jenkins user to docker group
RUN usermod -aG docker jenkins

# Change group ID based on group ID of docker in host machine
RUN groupmod -g 1001 docker

# Expose ports for jenkins service and accessing GUI
EXPOSE 8080
EXPOSE 50000


# Switch back to jenkins_home directory
WORKDIR /var/jenkins_home


# Switch back to jenkins user - best practice
USER jenkins
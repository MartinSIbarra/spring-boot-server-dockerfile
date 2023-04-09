FROM ubuntu:latest

# Updating apt-get
RUN apt-get update && apt-get upgrade

#Installing Java
RUN apt install openjdk-17-jre -y

#Installing Maven
RUN apt-get install wget -y
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz
RUN tar xvf apache-maven-3.9.1-bin.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.9.1 /opt/maven
RUN rm apache-maven-3.9.1-bin.tar.gz

ENV M2_HOME="/opt/maven"
ENV PATH="$M2_HOME/bin:$PATH"

EXPOSE 8080
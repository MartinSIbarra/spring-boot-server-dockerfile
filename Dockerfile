FROM ubuntu:latest

# Updating package manager
RUN apt-get update && apt-get upgrade

# Installing Java
RUN apt install openjdk-17-jre -y

# Installing Maven
RUN apt-get install wget -y
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz
RUN tar xvf apache-maven-3.9.1-bin.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.9.1 /opt/maven
RUN rm apache-maven-3.9.1-bin.tar.gz

ENV M2_HOME="/opt/maven"
ENV PATH="$M2_HOME/bin:$PATH"

# Creating User Runner
ARG gid=1000
ARG group=runner
ARG uid=1000
ARG user=runner

RUN groupadd -g "${gid}" "${group}"   
RUN useradd -l -c "Runner user" -d /home/${user} -u "${uid}" -g "${gid}" -m "${user}"

# Changing to Runner user
USER $user

# Creating App folder
RUN mkdir /home/"${user}"/app

# Setting entrypoint
ENV PATH "$PATH:/home/${user}/app/"

WORKDIR /home/${user}/app/

CMD [ "spring-boot:run" ]

ENTRYPOINT [ "mvnw" ]

EXPOSE 8080
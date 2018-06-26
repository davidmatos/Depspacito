FROM maven:3.5.0-jdk-7

COPY . /usr/src/depspacito

WORKDIR /usr/src/depspacito

RUN rm config/hosts.config

RUN echo "0 $(hostname -I) 11000" > config/hosts.config

RUN mvn clean && mvn install && mvn exec:java

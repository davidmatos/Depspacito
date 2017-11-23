#docker-compose up

FROM maven:3.5.0-jdk-7

COPY . /usr/src/depspacito

WORKDIR /usr/src/depspacito

RUN rm config/hosts.config \
  && echo "0 10.5.0.2 11000" > config/hosts.config \
  && echo "1 10.5.0.3 11010" >> config/hosts.config \
  && echo "2 10.5.0.4 11020" >> config/hosts.config \
  && echo "3 10.5.0.5 11030" >> config/hosts.config

RUN mvn clean && mvn install 



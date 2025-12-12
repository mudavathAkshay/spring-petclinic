FROM maven:3.9.11-eclipse-temurin-21-noble AS build
WORKDIR /app
ADD . /app
RUN mvn package

FROM eclipse-temurin:25.0.1_8-jre-noble as runtime
LABEL javaproject=scp
LABEL source=maven
ARG user=devops
RUN useradd -m -d /usr/share/${user} -s /bin/bash ${user}
USER ${user}
ENV JAVA_HOME=/usr/bin/jvm/openjdk-25-jdk/bin
ENV MAVEN_HOME=/usr/share/bin 
WORKDIR /usr/share/${user}/javaproject
EXPOSE 8080
COPY --from=build /app/target/*jar Akshay.jar
CMD ["java","-jar","Akshay.jar"]
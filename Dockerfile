FROM openjdk:17

EXPOSE 8082

ADD target/first-springboot-project-0.0.1-SNAPSHOT.jar firstspringbootproject.jar

ENTRYPOINT [ "java", "-jar", "/firstspringbootproject.jar" ]
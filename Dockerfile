FROM openjdk:17

EXPOSE 8082

ADD target/firstspringbootproject.jar firstspringbootproject.jar

ENTRYPOINT [ "java", "-jar", "/firstspringbootproject.jar" ]
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY backend/pom.xml backend/
COPY backend/src backend/src
RUN mvn -f backend/pom.xml -B -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/backend/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]

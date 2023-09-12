# Build Stage
FROM openjdk:22-slim-bullseye as build

WORKDIR /app

COPY . .

RUN ./build.sh

# Runtime Stage
FROM openjdk:8-alpine3.9 as runtime

RUN mkdir -p /opt/app

ENV PROJECT_HOME /opt/app

COPY --from=build /app/target/MyApp.class $PROJECT_HOME/MyApp.class

WORKDIR $PROJECT_HOME

RUN apk update && apk add /bin/sh

CMD ["java", "com.example.MyApp"]

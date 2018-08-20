# Hello World with Java 10 and Docker

A simple maven project generated from the using `maven-archetype-quickstart`
(`org.apache.maven.archetypes:maven-archetype-quickstart:1.0`) and updated
to declare the maven compiler source and target for Java 10.

Example Docker files are also present for building Docker images
containing a JDK 10 distribution.

## Pre-requisites

To experiment download the following and place in the top-level directory:
- OpenJDK build of [JDK 10 for Linux x64](http://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz/).

## Build Images and Run Containers

Build a Docker image with Alpine Linux and JDK 10:

    docker build -t jdk-10-alpine -f jdk-10-alpine.Dockerfile .

Build a Docker image with Debian slim and JDK 10:

    docker build -t jdk-10-debian-slim -f jdk-10-debian-slim.Dockerfile .

Run the docker image to enter into the Java REPL (jshell):

    docker run -it --rm jdk-10-debian-slim

List the Java modules in JDK 10:

    docker run -it --rm jdk-10-debian-slim java --list-modules

Build the simple Java application with a local distribution of JDK 10:

    mvnw package

Build a Docker image containing the simple Java application based of the Docker
image `jdk-10-debian-slim`:

    docker build -t helloworld-jdk-10 -f helloworld-jdk-10.Dockerfile .

Run the java dependency tool `jdeps` on the application jar file:

    docker run -it --rm helloworld-jdk-10 jdeps --list-deps /opt/helloworld/helloworld-1.0-SNAPSHOT.jar

Create a custom Java runtime that is small and only contains the `java.base` module:
(See also the script `create-minimal-java-runtime.sh`):

    docker run --rm \
      --volume $PWD:/out \
      jdk-10-debian-slim \
      jlink --module-path /opt/jdk-10/jmods \
        --verbose \
        --add-modules java.base \
        --compress 2 \
        --no-header-files \
        --output /out/target/openjdk-10-base_linux-x64

Build a Docker image containing the simple Java application based of the Docker
image `debian:slim` and the custom Java runtime previous created:

    docker build -t helloworld-jdk-10-base -f helloworld-jdk-10-base.Dockerfile .

List the modules in custom Java runtime:

    docker run -it --rm helloworld-jdk-10-base java --list-modules

Run the docker images:

    docker run -it --rm helloworld-jdk-10

    docker run -it --rm helloworld-jdk-10-base

Compare sizes:

    docker images

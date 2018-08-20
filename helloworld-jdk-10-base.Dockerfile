# Hello world application with custom Java runtime with just the base module and Debian slim
FROM debian:stable-slim
COPY target/openjdk-10-base_linux-x64 /opt/jdk-10
COPY target/helloworld-1.0-SNAPSHOT.jar /opt/helloworld/helloworld-1.0-SNAPSHOT.jar
# Set up env variables
ENV JAVA_HOME=/opt/jdk-10
ENV PATH=$PATH:$JAVA_HOME/bin
CMD java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap \
  -cp /opt/helloworld/helloworld-1.0-SNAPSHOT.jar org.examples.java.App

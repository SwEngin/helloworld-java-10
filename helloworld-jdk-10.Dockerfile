# Hello world application with JDK 10 and Debian slim
FROM jdk-10-debian-slim
COPY target/helloworld-1.0-SNAPSHOT.jar /opt/helloworld/helloworld-1.0-SNAPSHOT.jar
# Set up env variables
CMD java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap \
  -cp /opt/helloworld/helloworld-1.0-SNAPSHOT.jar org.examples.java.App

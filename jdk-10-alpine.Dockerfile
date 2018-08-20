# A JDK 10 with Alpine Linux
FROM alpine:3.8
# Download from http://jdk.java.net/10/
# Add https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz /opt
RUN mkdir /opt
COPY openjdk-10_linux-x64_bin.tar.gz /opt
RUN cd /opt \
	&& tar -xzvf openjdk-10_linux-x64_bin.tar.gz \
	&& rm -rf openjdk-10_linux-x64_bin.tar.gz
# Set up env variables
ENV JAVA_HOME /opt/jdk-10
ENV PATH $PATH:$JAVA_HOME/bin
CMD ["jshell", "-J-XX:+UnlockExperimentalVMOptions", \
               "-J-XX:+UseCGroupMemoryLimitForHeap", \
               "-R-XX:+UnlockExperimentalVMOptions", \
               "-R-XX:+UseCGroupMemoryLimitForHeap"]

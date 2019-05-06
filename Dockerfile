FROM centos:7

ENV JAVA_HOME=/usr/local/java
ENV CLASSPATH=./:$JAVA_HOME/lib:$JAVA_HOME/jre/lib/ext
ENV PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
ENV TZ=Asia/Shanghai

RUN yum install kde-l10n-Chinese -y
RUN yum install glibc-common -y
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

ENV LC_ALL zh_CN.UTF-8

COPY mime.types /etc/

COPY jdk-8u211-linux-x64.tar.gz /temp/

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN tar -xvf /temp/jdk-8u211-linux-x64.tar.gz -C /usr/local && ln -s /usr/local/jdk1.8.0_211 /usr/local/java \
&& echo "JAVA_HOME=$JAVA_HOME" >> /etc/profile \
&& echo "CLASSPATH=./:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib/ext" >> /etc/profile \
&& echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin" >> /etc/profile \
&& echo "export PATH JAVA_HOME CLASSPATH" >> /etc/profile \
&& rm -rf /temp/jdk-8u211-linux-x64.tar.gz

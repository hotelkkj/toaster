# Dockerfile

FROM java:8

MAINTAINER jyyu@yanolja.com

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 8080

WORKDIR data

ADD ROOT.jar /

CMD ["java", "-jar", "/ROOT.jar"]

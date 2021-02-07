FROM  adoptopenjdk/openjdk11-openj9:alpine
LABEL maintainer="harry@talos.software"
ENV SCALA_VERSION=2.13.4 \
  SCALA_HOME=/usr/share/scala \
  SBT_VERSION=1.4.7

# RUN \
RUN apk add --no-cache --virtual build-dependencies wget ca-certificates 
RUN apk add --no-cache bash
RUN wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz"
RUN tar xzf "scala-${SCALA_VERSION}.tgz"
RUN mkdir ${SCALA_HOME}
RUN ls ${SCALA_HOME}
RUN rm scala-${SCALA_VERSION}/bin/*.bat
RUN mv scala-${SCALA_VERSION}/bin ${SCALA_HOME}
RUN mv scala-${SCALA_VERSION}/lib ${SCALA_HOME}
RUN ln -s ${SCALA_HOME}/bin/* /usr/bin/
RUN rm -rf /tmp/* 
RUN rm -rf scala-${SCALA_VERSION}
RUN find . 
RUN scala -version
RUN scalac -version
RUN echo $SCALA_VERSION $SBT_VERSION
RUN apk add --no-cache bash curl bc ca-certificates
RUN update-ca-certificates
RUN curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local
RUN $(mv /usr/local/sbt-launcher-packaging-$SBT_VERSION /usr/local/sbt || true)
RUN ln -s /usr/local/sbt/bin/* /usr/local/bin/
RUN apk del curl
RUN sbt -Dsbt.rootdir=true sbtVersion

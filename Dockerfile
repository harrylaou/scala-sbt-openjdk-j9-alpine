FROM  adoptopenjdk/openjdk11-openj9:alpine
LABEL maintainer="harry@talos.software"
ENV SCALA_VERSION=2.13.4 \
  SCALA_HOME=/usr/share/scala \
  SBT_VERSION=1.4.7

# RUN \
RUN apk add --no-cache --virtual build-dependencies wget ca-certificates && \
 apk add --no-cache bash && \
 wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
 tar xzf "scala-${SCALA_VERSION}.tgz" && \
 mkdir ${SCALA_HOME} && \
 ls ${SCALA_HOME} && \
 rm scala-${SCALA_VERSION}/bin/*.bat && \
 mv scala-${SCALA_VERSION}/bin ${SCALA_HOME} && \
 mv scala-${SCALA_VERSION}/lib ${SCALA_HOME} && \
 ln -s ${SCALA_HOME}/bin/* /usr/bin/ && \
 rm -rf /tmp/*  && \
 rm -rf scala-${SCALA_VERSION} && \
 scala -version && \
 scalac -version && \
 echo $SCALA_VERSION $SBT_VERSION && \
 apk add --no-cache bash curl bc ca-certificates && \
 update-ca-certificates && \
 curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local && \
 $(mv /usr/local/sbt-launcher-packaging-$SBT_VERSION /usr/local/sbt || true) && \
 ln -s /usr/local/sbt/bin/* /usr/local/bin/ && \
 apk del curl && \
 sbt -Dsbt.rootdir=true sbtVersion 

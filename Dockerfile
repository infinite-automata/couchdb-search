FROM gliderlabs/alpine:3.3
MAINTAINER Infinite Automata Community <info@infinite.ai>
ENV COUCHDB_LUCENE_VERSION 1.0.2
ENV JAVA_HOME /usr/lib/jvm/java-1.7-openjdk/jre
RUN echo "@testing https://alpine.gliderlabs.com/alpine/edge/testing/" >> /etc/apk/repositories \
    && apk --update add openjdk7 maven@testing openssl java-cacerts ca-certificates \
    && /etc/ca-certificates/update.d/java-cacerts \
    && ln -sf /etc/ssl/certs/java/cacerts $JAVA_HOME/lib/security/cacerts \
    && mkdir -p /tmp/build /srv \
    && cd /tmp/build \
    && wget -O- "https://github.com/rnewson/couchdb-lucene/archive/v$COUCHDB_LUCENE_VERSION.tar.gz" \
        | tar -xzf - \
    && cd couchdb-lucene-$COUCHDB_LUCENE_VERSION \
    && /usr/share/java/maven-3.3.3/bin/mvn \
    && tar -C /srv/ -xzf target/couchdb-lucene-$COUCHDB_LUCENE_VERSION-dist.tar.gz \
    && mv /srv/couchdb-lucene-$COUCHDB_LUCENE_VERSION /srv/couchdb-lucene \
    && mkdir -p /srv/couchdb-lucene/indexes \
    && chmod o+w /srv/couchdb-lucene/indexes \
    && apk del maven \
    && rm -rf /tmp/build /root/.m2
VOLUME ["/srv/couchdb-lucene/conf/", "/srv/couchdb-lucene/indexes/"]
USER nobody
ENTRYPOINT ["/srv/couchdb-lucene/bin/run"]

FROM gliderlabs/alpine:3.3

ENV COUCHDB_LUCENE_VERSION 1.0.2
ENV CONFD_VERSION 0.11.0
ENV JAVA_HOME /usr/lib/jvm/java-1.7-openjdk/jre

ENV COUCHDB_SEARCH_INDEXES /srv/couchdb-lucene/indexes
ENV COUCHDB_SEARCH_HOST localhost
ENV COUCHDB_SEARCH_PORT 5985
ENV COUCHDB_SEARCH_REQUEST_TIMEOUT 10000
ENV COUCDHB_SEARCH_CHANGES_TIMEOUT 60000
ENV COUCHDB_SEARCH_DEFAULT_RESULT_LIMIT 25
ENV COUCHDB_SEARCH_ALLOW_LEADING_WILDCARD false
ENV COUCHDB_PROTOCOL http
ENV COUCHDB_HOST localhost
ENV COUCHDB_PORT 5984

RUN mkdir -p /tmp/build /srv
COPY Makefile /tmp/build/Makefile
WORKDIR /tmp/build
RUN echo "@testing https://alpine.gliderlabs.com/alpine/edge/testing/" >> /etc/apk/repositories \
    && apk --update add sudo make curl maven@testing openjdk7 openssl java-cacerts ca-certificates \
    && make install \
    && chmod o+w /srv/couchdb-lucene/indexes \
    && apk del --purge make maven curl \
    && rm -rf /tmp/build /root/.m2
COPY bin /srv/bin
COPY etc /etc/confd
VOLUME ["/srv/couchdb-lucene/indexes/"]
ENTRYPOINT ["/srv/bin/start.sh"]

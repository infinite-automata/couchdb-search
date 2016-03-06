COUCHDB_LUCENE_URL := https://github.com/rnewson/couchdb-lucene/archive/v$(COUCHDB_LUCENE_VERSION).tar.gz
CONFD_URL := https://github.com/kelseyhightower/confd/releases/download/v$(CONFD_VERSION)/confd-$(CONFD_VERSION)-linux-amd64

maven = /usr/share/java/maven-3.3.3/bin/mvn

fix-ca:
	/etc/ca-certificates/update.d/java-cacerts
	ln -sf /etc/ssl/certs/java/cacerts $(JAVA_HOME)/lib/security/cacerts

build:
	+make fix-ca
	curl -L $(COUCHDB_LUCENE_URL) | tar -xzf -
	cd couchdb-lucene-$(COUCHDB_LUCENE_VERSION) && $(maven)
	tar -C /srv/ -xzf couchdb-lucene-$(COUCHDB_LUCENE_VERSION)/target/couchdb-lucene-$(COUCHDB_LUCENE_VERSION)-dist.tar.gz
	mv /srv/couchdb-lucene-$(COUCHDB_LUCENE_VERSION) /srv/couchdb-lucene
	mkdir -p /srv/couchdb-lucene/indexes

confd:
	curl -L $(CONFD_URL) > /usr/local/bin/confd
	chmod +x /usr/local/bin/confd

install: build confd

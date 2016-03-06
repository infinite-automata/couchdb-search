#!/bin/sh

confd -onetime -backend env

exec sudo -u nobody /srv/couchdb-lucene/bin/run

## quay.io/infiniteautomata/couchdb-search

A container for indexing CouchDB databases. Packages
[`rnewson/couchdb-lucene`][couchdb-lucene].

## configuration

`couchdb-search` is configurable using the following environment variables.
Configuration is generated at runtime.

- `COUCHDB_SEARCH_INDEXES`: The path to store lucene indexes (default `/srv/couchdb-lucene/indexes/`)
- `COUCHDB_SEARCH_HOST`: The host for `couchdb-lucene` to listen on (default `localhost`)
- `COUCHDB_SEARCH_PORT`: The port for `couchdb-lucene` to listen on (default `5985`)
- `COUCHDB_SEARCH_REQUEST_TIMEOUT`: Request timeout
- `COUCHDB_SEARCH_CHANGES_TIMEOUT`: Changes timeout
- `COUCHDB_SEARCH_DEFAULT_RESULT_LIMIT`: Default result limit (default `25`)
- `COUCHDB_SEARCH_ALLOW_LEADING_WILDCARD`: Allow leading wildcard in queries (default `false`)
- `COUCHDB_USERNAME`: CouchDB username
- `COUCHDB_PASSWORD`: CouchDB password
- `COUCHDB_PROTOCOL`: CouchDB protocol (default `http`)
- `COUCHDB_HOST`: CouchDB host
- `COUCHDB_PORT`: CouchDB port

[couchdb-lucene]: https://github.com/rnewson/couchdb-lucene

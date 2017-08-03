FROM postgres:alpine

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh docker-entrypoint.sh

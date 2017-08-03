FROM postgres:alpine

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

# port for postgres
EXPOSE 5432

COPY docker-entrypoint.sh docker-entrypoint.sh

CMD ["postgres"]

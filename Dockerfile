FROM postgres:alpine

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

# port for postgres
EXPOSE 5432

CMD ["postgres"]

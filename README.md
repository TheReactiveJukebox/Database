# DBMS im Dockercontainer
Dieses Repo enthält einen Dockercontainer mit dem Datenbankmanagementsystem (DBMS) PostgreSQL in der Version 9.6, das unsere Datenbank __reactivejukebox__ bereitstellt.
Diese Datenbank enthält erste Tabellen und Beispieldaten.
Der Dockercontainer baut auf den [postgres:alpin](https://hub.docker.com/_/postgres/) Container auf.

Um sich mit der Datenbank reactivejukebox zu verbinden, steht das Benutzerkonto __backend__ mit Passwort __backend__ im DBMS zur Verfügung.

## starte Dockercontainer
1. Erzeuge Container image mit `docker build .`
2. Starte Container mit `dokcer run $ID`

## einem Container mit dem DBMS-Container verbinden
Wir starten einen weiteren Dockercontainer den wir mit dem DBMS-Container verbinden und so zwischen den Containern eine Verbindung zur Datenbank herstellen.

1. Container ID des DBMS Containers mit `docker ps` nachschlagen
2. wir starten einen neuen Dockercontainer mit `docker run -it --rm --link $ID:db postgres:alpin psql -h db -U backend -W reactivejukebox`. Dabei vergeben wir den DBMS Container den Alias *DB* unter diesem Hostname kann der DBMS Container aus dem neuen Container aus erreicht werden. Das Abgefragte Passwort ist wie oben beschrieben *backend*.

Wir erhalten eine psql Prompt, die mit der Datenbank reactivejukebox verbunden ist. Jetzt können wir Abfragen an das DBMS senden z.B. `SELECT * FROM users;`.

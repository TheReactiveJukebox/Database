# DBMS im Docker Container
Dieses Repo enthält ein Docker Image mit dem Datenbankmanagementsystem (DBMS) PostgreSQL in der Version 9.6, das unsere Datenbank __reactivejukebox__ bereitstellt.
Diese Datenbank enthält erste Tabellen und Beispieldaten.
Das Image baut auf [postgres:alpine](https://hub.docker.com/_/postgres/) auf.

Um sich mit der Datenbank reactivejukebox zu verbinden, steht das Benutzerkonto `backend` mit Passwort `backend` im DBMS zur Verfügung.

## Docker Container starten
1. Erzeuge Docker Image mit `docker build -t <imagename> .`
2. Starte Container mit `docker run <imagename>`

## Dockercontainer mit Datenbank im lokalen Verzeichnis starten (persistent)
1. Erzeuge Docker Image mit `docker build -t <imagename> .`
2. Starte Container mit `docker run -v $(pwd)/data:/var/lib/postgresql/data <imagename>`
Dabei wird durch den Parameter -v getrennt durch einen : (Doppelpunkt) Hostdir und Containerdir angegeben.
Das Hostdir ist das Verzeichnis auf dem System, das in den Container eingebunden werden soll und das Containerdir der entsprechende Mountpoint im Container ist.
Dabei müssen jeweils **absolute Pfade** angegeben werden.
Das Hostdir muss nicht extra angelegt werden.

## Vom Hostsystem mit dem DBMS verbinden
Um sich vom Hostsystem aus mit dem DBMS im Cotainer zu verbinden, muss der Container mit dem zusätzlichen Parameter `-p` gestartet werden.
Dieser Parameter weist Docker an, den Port 5432, auf dem PostgreSQL im Container auf eingehende Verbindungen wartet, auf einen Port vom Hostsystem abzubilden.
Wenn man den Container z.B. mit `docker run -p 5432:5432 <imagename>` startet, kann man sich auf `localhost:5432` mit dem DBMS verbinden, z.B. mit `psql -h localhost -U backend -W reactivejukebox`.

## Einen Container mit dem DBMS-Container verbinden
Wir starten einen weiteren Docker Container, den wir mit dem DBMS-Container verbinden, um aus dem ersten Container eine Verbindung zur Datenbank herstellen zu können.

1. Container-ID des DBMS-Containers mit `docker ps` nachschlagen
2. Wir starten einen neuen Docker Container mit `docker run -it --rm --link <container-id>:db postgres:alpine psql -h db -U backend -W reactivejukebox`. Dabei vergeben wir für den DBMS Container den Alias *db*. Unter diesem Hostname kann der DBMS Container aus dem neuen Container erreicht werden. Das abgefragte Passwort ist wie oben beschrieben `backend`.

Wir erhalten eine psql Prompt, die mit der Datenbank reactivejukebox verbunden ist. Jetzt können wir Abfragen an das DBMS senden, z.B.: `SELECT * FROM users;`.

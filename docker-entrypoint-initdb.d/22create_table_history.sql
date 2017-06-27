--- switch into database reactivejukebox
\connect reactivejukebox

--- create table history
--- Time in UTC
CREATE TABLE history (
    Id serial PRIMARY KEY,
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    UserId INTEGER REFERENCES "user" (Id) NOT NULL,
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (SongId, RadioId, UserId, Time)
);

CREATE VIEW historyview AS
    SELECT "user".Name AS UserName, history.RadioId, array_agg(artist.Name) AS Artists, song.Title AS SongTitel, history.Time
    FROM history
    JOIN song ON (song.Id = history.SongId)
    JOIN song_artist ON (song.Id = song_artist.SongId)
    JOIN artist ON (artist.Id = song_artist.ArtistId)
    JOIN "user" ON ("user".Id = history.UserId)
    GROUP BY UserName, RadioId, SongTitel, Time
    ORDER BY Time
;

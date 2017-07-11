-- noinspection SqlDialectInspectionForFile

-- noinspection SqlNoDataSourceInspectionForFile

--- switch into database reactivejukebox
\connect reactivejukebox

--- create table artist
CREATE TABLE artist (
    Id serial PRIMARY KEY,
    NameNormalized varchar(256) NOT NULL UNIQUE,
    Name text NOT NULL,
    MusicBrainzId char(36) NULL,
    Rating DECIMAL(2,1),
    CONSTRAINT non_empty CHECK (length(NameNormalized) > 0 and length(Name) > 0)
);

--- create table album
CREATE TABLE album (
    Id serial PRIMARY KEY,
    TitleNormalized varchar(256) NOT NULL UNIQUE,
    Title text NOT NULL,
    Cover text NULL,
    MusicBrainzId char(36) NULL,
    CONSTRAINT non_empty CHECK (length(TitleNormalized) > 0 and length(Title) > 0)
);

--- create table album_artist as cross reference between artist and album
CREATE TABLE album_artist (
    ArtistId INTEGER REFERENCES artist (Id) NOT NULL,
    AlbumId INTEGER REFERENCES album (Id) NOT NULL,
    UNIQUE (ArtistId, AlbumId)
);

--- create table song
--- hashSong is a sha256 hash
CREATE TABLE song (
    Id serial PRIMARY KEY,
    TitleNormalized varchar(512) NOT NULL UNIQUE,
    Title text NOT NULL,
    AlbumId INTEGER REFERENCES album (Id) NULL,
    Hash char(64) NULL UNIQUE,
    Duration integer NOT NULL,
    Published DATE NULL,
    MusicBrainzId char(36) NULL,
    Playcount integer NULL,
    Listeners integer NULL,
    Rating DECIMAL(2,1),
    CONSTRAINT non_empty CHECK (length(TitleNormalized) > 0 and length(Title) > 0),
    CONSTRAINT sha256hash CHECK (char_length(Hash) = 64),
    CONSTRAINT nonnegativ_duration CHECK (Duration >= 0)
);

--- create table song_artist as cross reference between song and artist
CREATE TABLE song_artist (
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    ArtistId INTEGER REFERENCES artist (Id) NOT NULL,
    Featured boolean DEFAULT FALSE NOT NULL,
    UNIQUE (SongId, ArtistId)
);

--- create table genre
CREATE TABLE genre (
    Id serial PRIMARY KEY,
    Name text NOT NULL
);

--- create table song_genre as cross reference between song and genre
CREATE TABLE song_genre (
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    GenreId INTEGER REFERENCES genre (Id) NOT NULL,
    UNIQUE (SongId, GenreId)
);

--- create view songview with array of artist for a song
CREATE VIEW songview AS
    SELECT song.Id AS SongId, song.Title, song.Duration, song.Hash, array_agg(artist.Name) AS Artists, album.Id AS AlbumId, album.Title AS AlbumTitle, album.Cover
    FROM song
    LEFT OUTER JOIN song_artist ON (song.Id = song_artist.SongId)
    LEFT OUTER JOIN artist ON (artist.Id = song_artist.ArtistId)
    LEFT OUTER JOIN album ON (album.Id = song.AlbumId)
    GROUP BY song.Id, song.Title, song.Duration, song.Hash, album.Id, AlbumTitle, album.Cover
;

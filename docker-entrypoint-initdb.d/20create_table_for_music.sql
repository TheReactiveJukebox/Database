--- switch into database reactivejukebox
\connect reactivejukebox

--- create table artist
CREATE TABLE artist (
    idArtist serial PRIMARY KEY,
    strArtistNormalized varchar(256) NOT NULL UNIQUE,
    strArtist text NOT NULL,
    CONSTRAINT non_empty CHECK (length(strArtistNormalized) > 0 and length(strArtist) > 0)
);

--- create table album
CREATE TABLE album (
    idAlbum serial PRIMARY KEY,
    strAlbumNormalized varchar(256) NOT NULL UNIQUE,
    strAlbum text NOT NULL,
    strCover text NULL,
    CONSTRAINT non_empty CHECK (length(strAlbumNormalized) > 0 and length(strAlbum) > 0)
);

--- create table album_artist as cross reference between artist and album
CREATE TABLE album_artist (
    idArtist INTEGER REFERENCES artist (idArtist) NOT NULL,
    idAlbum INTEGER REFERENCES album (idAlbum) NOT NULL,
    UNIQUE (idArtist, idAlbum)
);

--- create table song
--- hashSong is a sha256 hash
CREATE TABLE song (
    idSong serial PRIMARY KEY,
    strTitleNormalized varchar(512) NOT NULL UNIQUE,
    strTitle text NOT NULL,
    idAlbum INTEGER REFERENCES album (idAlbum) NULL,
    hashSong char(64) NULL UNIQUE,
    iDuration integer NOT NULL,
    CONSTRAINT non_empty CHECK (length(strTitleNormalized) > 0 and length(strTitle) > 0),
    CONSTRAINT sha256hash CHECK (char_length(hashSong) = 64),
    CONSTRAINT nonnegativ_duration CHECK (iDuration >= 0)
);

--- create table song_artist as cross reference between song and artist
CREATE TABLE song_artist (
    idSong INTEGER REFERENCES song (idSong) NOT NULL,
    idArtist INTEGER REFERENCES artist (idArtist) NOT NULL,
    boolFeatured boolean DEFAULT FALSE NOT NULL,
    UNIQUE (idSong, idArtist)
);

--- create view songview with array of artist for a song
CREATE VIEW songview AS
    SELECT song.idSong, song.strTitle, song.iDuration, song.hashSong, array_agg(artist.strArtist) AS arrArtist, album.idAlbum, album.strAlbum, album.strCover
    FROM song
    LEFT OUTER JOIN song_artist ON (song.idsong = song_artist.idsong)
    LEFT OUTER JOIN artist ON (artist.idArtist = song_artist.idArtist)
    LEFT OUTER JOIN album ON (album.idAlbum = song.idAlbum)
    GROUP BY song.idSong, song.strTitle, song.iDuration, song.hashSong, album.idAlbum, album.strAlbum, album.strCover
;

--- switch into database reactivejukebox
\connect reactivejukebox

--- create table artist
CREATE TABLE artist (
    idArtist serial PRIMARY KEY,
    strArtist varchar(256) NOT NULL UNIQUE
);

--- create table album
CREATE TABLE album (
    idAlbum serial PRIMARY KEY,
    strAlbum varchar(256) NOT NULL
);

--- create table album_artist as cross reference between artist and album
CREATE TABLE album_artist (
    idArtist INTEGER REFERENCES artist (idArtist) NOT NULL,
    idAlbum INTEGER REFERENCES album (idAlbum) NOT NULL,
    UNIQUE (idArtist, idAlbum)
);

--- create table song
CREATE TABLE song (
    idSong serial PRIMARY KEY,
    strTitle varchar(512) NOT NULL UNIQUE,
    idAlbum INTEGER REFERENCES album (idAlbum) NULL,
    idSongfile INTEGER REFERENCES album (idAlbum) NULL
);

--- create table song_artist as cross reference between song and artist
CREATE TABLE song_artist (
    idSong INTEGER REFERENCES song (idSong) NOT NULL,
    idArtist INTEGER REFERENCES artist (idArtist) NOT NULL,
    UNIQUE (idSong, idArtist)
);

--- create table songfile
--- songhash is a sha256 hash
CREATE TABLE songfile (
    idSongfile serial PRIMARY KEY,
    songhash char(64) NOT NULL UNIQUE,
    CONSTRAINT sha256hash CHECK (char_length(songhash) = 64)
);

--- create view songview with array of artist for a song
CREATE VIEW songview AS
    SELECT song.idSong, song.strTitle, array_agg(artist.strArtist) AS arrArtist, album.idAlbum, album.strAlbum, songfile.songhash
    FROM song
    LEFT OUTER JOIN song_artist ON (song.idsong = song_artist.idsong)
    LEFT OUTER JOIN artist ON (artist.idArtist = song_artist.idArtist)
    LEFT OUTER JOIN album ON (album.idAlbum = song.idAlbum)
    LEFT OUTER JOIN songfile ON (songfile.idSongfile = song.idSongfile)
    GROUP BY song.idSong, song.strTitle, album.idAlbum, album.strAlbum, songfile.songhash
;

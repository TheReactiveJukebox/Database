--- switch into database reactivejukebox
\connect reactivejukebox

--- create table for absolute frequency of songs in playlists
CREATE TABLE song_frequency
(
    song1 INT NOT NULL,
    song2 INT NOT NULL,
    freq INT NOT NULL,
    CONSTRAINT song_frequency_pk PRIMARY KEY (song1, song2)
);

--- switch into database reactivejukebox
\connect reactivejukebox

--- create table for absolute frequency of songs in playlists
CREATE TABLE feature_distance
(
    track_from INT NOT NULL,
    track_to INT NOT NULL,
    distance INT NOT NULL,
    CONSTRAINT feature_distance_pk PRIMARY KEY (track_from, track_to)
);

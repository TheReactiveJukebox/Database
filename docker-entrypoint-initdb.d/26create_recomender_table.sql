--- switch into database reactivejukebox
\connect reactivejukebox

--- create table for absolute frequency of songs in playlists
CREATE TABLE feature_distance
(
    track_from INTEGER REFERENCES song (Id) NOT NULL,
    track_to INTEGER REFERENCES song (Id) NOT NULL,
    distance DOUBLE PRECISION NOT NULL,
    CONSTRAINT feature_distance_pk PRIMARY KEY (track_from, track_to)
);

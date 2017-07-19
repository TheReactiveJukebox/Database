--- switch into database reactivejukebox
\connect reactivejukebox

--- create table radio
CREATE TABLE radio (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    AlgorithmName varchar(16) NOT NULL,
    StartYear INTEGER NULL,
    EndYear INTEGER NULL,
    CONSTRAINT non_empty CHECK (length(AlgorithmName) > 0),
    CONSTRAINT complete_interval CHECK ((StartYear IS NULL and EndYear IS NULL) or (StartYear IS NOT NULL and EndYear IS NOT NULL))
);

CREATE TABLE radio_song (
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    Position INTEGER NULL,
    UNIQUE (RadioId, SongId)
);

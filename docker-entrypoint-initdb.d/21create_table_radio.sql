--- switch into database reactivejukebox
\connect reactivejukebox

--- create table radio
CREATE TABLE radio (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    AlgorithmName varchar(16) NOT NULL,
    StartYear INTEGER NULL CHECK (StartYear > 1000 and StartYear < 3000),
    EndYear INTEGER NULL CHECK (EndYear > 1000 and EndYear < 3000),
    CONSTRAINT non_empty CHECK (length(AlgorithmName) > 0)
);

CREATE TABLE radio_song (
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    Position INTEGER NULL,
    UNIQUE (RadioId, SongId)
);

CREATE TABLE radio_genre (
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    GenreId INTEGER REFERENCES genre (Id) NOT NULL,
    UNIQUE (RadioId, GenreId)
);

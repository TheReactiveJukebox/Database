--- switch into database reactivejukebox
\connect reactivejukebox

--- create table radio
CREATE TABLE radio (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    IsRandom BOOLEAN NOT NULL,
    AlgorithmName varchar(16) NOT NULL,
    CONSTRAINT non_empty CHECK (length(AlgorithmName) > 0)
);

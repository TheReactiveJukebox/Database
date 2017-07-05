--- switch into database reactivejukebox
\connect reactivejukebox

--- create table radio
CREATE TABLE radio (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    IsRandom BOOLEAN NOT NULL
);

--- switch into database reactivejukebox
\connect reactivejukebox

--- create table indirectfeedback
CREATE TABLE indirectFeedback (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    Type VARCHAR(16) NOT NULL CHECK (position >= 0),
    Position INTEGER NULL,
    ToSongId INTEGER REFERENCES song (Id) NULL,
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (UserId, RadioId, SongId, Type, Time)
);

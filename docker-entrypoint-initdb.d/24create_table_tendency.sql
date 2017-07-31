--- switch into database reactivejukebox
\connect reactivejukebox

--- create table tendency

CREATE TABLE tendency (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    MoreDynamics BOOLEAN,
    LessDynamics BOOLEAN,
    Faster BOOLEAN,
    Slower BOOLEAN,
    Older BOOLEAN,
    Newer BOOLEAN,
    MoreOfGenre varchar(25),
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (RadioId, UserId, Time)
);



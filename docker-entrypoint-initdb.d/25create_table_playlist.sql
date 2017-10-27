--- switch into database reactivejukebox
\connect reactivejukebox

--- create table playlist

CREATE TABLE playlist (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    Title  varchar(25) NOT NULL,
    IsPublic BOOLEAN,
    CreatedAt TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    EditedAt TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    Tracks integer[],
    Tags varchar(25)[],
    UNIQUE (UserId, Title)
);



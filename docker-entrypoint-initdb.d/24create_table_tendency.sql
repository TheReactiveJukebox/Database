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
    PeriodStartOlder BOOLEAN,
    PeriodStartNewer BOOLEAN,
    PeriodEndOlder BOOLEAN,
    PeriodEndNewer BOOLEAN,
    MoreOfGenre varchar(25),
    PreferredDynamics FLOAT CHECK (PreferredDynamics >= 0 AND PreferredDynamics <= 1),
    PreferredSpeed INTEGER CHECK (PreferredSpeed > 0),
    PreferredPeriodStart INTEGER,
    PreferredPeriodEnd INTEGER,
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (RadioId, UserId, Time)
);



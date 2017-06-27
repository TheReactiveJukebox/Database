--- switch into database reactivejukebox
\connect reactivejukebox

--- create table users
--- Password is a sha256 hash
CREATE TABLE "user" (
    Id serial PRIMARY KEY,
    Name varchar(25) NOT NULL UNIQUE,
    Password char(64) NULL,
    Token char(16) NULL UNIQUE,
    CONSTRAINT sha256hash CHECK (length(Password) = 64)
);

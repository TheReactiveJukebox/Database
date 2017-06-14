--- switch into database reactivejukebox
\connect reactivejukebox

--- create table users
--- pw is a sha256 hash
CREATE TABLE users (uid serial PRIMARY KEY, username varchar(25) NOT NULL UNIQUE, pw char(64) NULL, token char(16) NULL UNIQUE, CONSTRAINT sha256hash CHECK (char_length(pw) = 64));

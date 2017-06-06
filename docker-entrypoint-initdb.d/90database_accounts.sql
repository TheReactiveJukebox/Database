--- create user backend
CREATE USER backend WITH NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD 'xxx';

--- switch into database reactivejukebox
\connect reactivejukebox

--- give user backend access for select, update and insert operations on table users
GRANT SELECT, UPDATE, INSERT ON TABLE users TO backend;

--- create user backend
CREATE USER backend WITH NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD 'xxx';

--- give user backend rights for database reactivejukebox
GRANT ALL PRIVILEGES ON DATABASE reactivejukebox TO backend;

--- switch into database reactivejukebox
\connect reactivejukebox

--- give user backend rights for table users in database backend
GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO backend;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO backend;

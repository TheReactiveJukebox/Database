--- create user backend
CREATE USER backend WITH NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD 'xxx';

--- give user backend access for select, update and insert operations on table users
GRANT ALL PRIVILEGES ON DATABASE reactivejukebox TO backend;

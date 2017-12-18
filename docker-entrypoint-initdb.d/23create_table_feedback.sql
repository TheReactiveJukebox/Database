--- switch into database reactivejukebox
\connect reactivejukebox

--- create table feedback
--- When a user likes a certain feature of a song, the according column will be 1.  
--- Likewise it will be -1, in case the user disliked a feature. 
--- If the useres state of mind towards a feature of a song is unknown, the column will be 0.

CREATE TABLE feedback (
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    SongId INTEGER REFERENCES song (Id) NOT NULL,
    FeedbackSong INTEGER NOT NULL CHECK (FeedbackSong >= -1 AND FeedbackSong <= 1),
    FeedbackSpeed INTEGER NOT NULL CHECK (FeedbackSpeed >= -1 AND FeedbackSpeed <= 1),
    FeedbackDynamics INTEGER NOT NULL CHECK (FeedbackDynamics >= -1 AND FeedbackDynamics <= 1),
    FeedbackMood INTEGER NOT NULL CHECK (FeedbackMood >= -1 AND FeedbackMood <= 1),
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (SongId, UserId)
);

CREATE TABLE feedbackArtist(
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    ArtistId INTEGER REFERENCES artist (Id) NOT NULL,
    FeedbackArtist INTEGER NOT NULL CHECK (FeedbackArtist >= -1 AND FeedbackArtist <= 1),
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (ArtistId, UserId)
);

CREATE TABLE feedbackGenre(
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    Genre text NOT NULL,
    FeedbackGenre INTEGER NOT NULL CHECK (FeedbackGenre >= -1 AND FeedbackGenre <= 1),
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (Genre, UserId)
);

CREATE TABLE feedbackAlbum(
    Id serial PRIMARY KEY,
    UserId INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    AlbumId INTEGER REFERENCES album (Id) NOT NULL,
    FeedbackAlbum INTEGER NOT NULL CHECK (FeedbackAlbum >= -1 AND FeedbackAlbum <= 1),
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (AlbumId, UserId)
);
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
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    FeedbackSong INTEGER NOT NULL,
    FeedbackArtist INTEGER NOT NULL,
    FeedbackTempo INTEGER NOT NULL,
    FeedbackGenre INTEGER NOT NULL,
    FeedbackDynamics INTEGER NOT NULL,
    FeedbackPeriod INTEGER NOT NULL,
    FeedbackMood INTEGER NOT NULL,
    Time TIMESTAMP (0) without time zone NOT NULL DEFAULT (now() at time zone 'utc'),
    UNIQUE (SongId, RadioId, UserId)
);



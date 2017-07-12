--- switch into database reactivejukebox
\connect reactivejukebox

--- create table feedback
CREATE TABLE feedback (
    Id serial PRIMARY KEY,
    Decription INTEGER REFERENCES jukebox_user (Id) NOT NULL,
    UNIQUE (Decription)
);

--- create table feedbackreason
CREATE TABLE feedbackreason (
    Id serial PRIMARY KEY,
    Name text NOT NULL,
    IsLike BOOLEAN NOT NULL
);

--- create table feedback_radiostation
CREATE TABLE feedback_radiostation (
    FeedbackId INTEGER REFERENCES feedback (Id) NOT NULL,
    RadioId INTEGER REFERENCES radio (Id) NOT NULL,
    UNIQUE (FeedbackId, RadioId)
);

--- create table feedback_feedbackreason
CREATE TABLE feedback_feedbackreason (
    FeedbackId INTEGER REFERENCES feedback (Id) NOT NULL,
    ReasonId INTEGER REFERENCES feedbackreason (Id) NOT NULL,
    UNIQUE (FeedbackId, ReasonId)
);

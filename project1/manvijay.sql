CREATE TABLE Users(
	userName VARCHAR(30) NOT NULL,
	displayName VARCHAR(30) NOT NULL UNIQUE,
	passwords VARCHAR(30) NOT NULL,
	logInTime TIMESTAMP NOT NULL,
	logOutTime TIMESTAMP NOT NUll,
	signUpDate DATE NOT NULL,
  PRIMARY KEY (userName)
	);
  
CREATE TABLE Tweet(
	tweetID BIGINT NOT NULL,
	tweetData VARCHAR(140),
	tweetTime TIMESTAMP NOT NULL,
	postStatus BOOLEAN NOT NULL,
  PRIMARY KEY (tweetID)
	);  
  
CREATE TABLE Follows(
 	follower VARCHAR(30),
    followin VARCHAR(30),
  FOREIGN KEY(follower) REFERENCES Users(userName),
  FOREIGN KEY(followin) REFERENCES Users(userName),
  PRIMARY KEY(follower, followin)
	);
 
CREATE TABLE CommentsOn(
     userName VARCHAR(30) REFERENCES Users(userName), 
     tweetID BIGINT REFERENCES Tweet(tweetID),  
     commentData VARCHAR(140),
     commentTime TIMESTAMP NOT NULL,
  PRIMARY KEY(userName,tweetID,commentTime)
    );
    
CREATE TABLE Likes(
     userName VARCHAR(30) REFERENCES Users(userName),  
     tweetID BIGINT REFERENCES Tweet(tweetID),
  PRIMARY KEY(userName,tweetID)
    );
    
CREATE TABLE Creates(
     userName VARCHAR(30) REFERENCES Users(userName),  
     tweetID BIGINT REFERENCES Tweet(tweetID),
  PRIMARY KEY(userName,tweetID)
    );
    
CREATE TABLE Deletes(
     userName VARCHAR(30) REFERENCES Users(userName),  
     tweetID BIGINT REFERENCES Tweet(tweetID),
  PRIMARY KEY(userName,tweetID)
    );
    
CREATE TABLE Retweet(
     userName VARCHAR(30) REFERENCES Users(userName), 
     tweetID BIGINT REFERENCES Tweet(tweetID),  
     retweetData VARCHAR(140),
     retweetTime TIMESTAMP NOT NULL,
  PRIMARY KEY(userName,tweetID,retweetTime)
    );
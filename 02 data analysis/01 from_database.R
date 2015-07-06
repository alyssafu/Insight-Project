library('RMySQL')

# Load data from databases

query = "SELECT comments2.*, posts1000_2.* FROM comments2, posts1000_2 WHERE posts1000_2.postID = comments2.postID AND (postPeriod = 'Apr2015' OR postPeriod = 'May2015')"

drv = dbDriver("MySQL")

dbConGetQ = function(subreddit, query) {
  con = dbConnect(drv, user = 'root', dbname = subreddit, host = 'localhost')
  return(dbGetQuery(con, query))
}

dfPic = dbConGetQ('pics', query)
dfPol = dbConGetQ('politics', query)
dfLoL = dbConGetQ('leagueoflegends', query)
dfGG = dbConGetQ('GirlGamers', query)

# Check that the data is the same
length(unique(dfPic$commentID)) == length(dfPic$commentID)
length(unique(dfPol$commentID)) == length(dfPol$commentID)
length(unique(dfLoL$commentID)) == length(dfLoL$commentID)
length(unique(dfGG$commentID)) == length(dfGG$commentID)

# Concatenate each dataframe into one dataframe
redditOrig = rbind(dfLoL, dfPol, dfPic, dfGG)

# Check the combined data
length(unique(redditOrig$commentID)) == sum(
  length(unique(dfPic$commentID)),
  length(unique(dfPol$commentID)),
  length(unique(dfLoL$commentID)),
  length(unique(dfGG$commentID))
  )

#### SAVED ### 01 redditOrig.RData
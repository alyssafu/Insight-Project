library(plyr)

reddit = redditOrig

reddit = reddit[,-c(grep("index", names(reddit)))]
reddit = subset(reddit, select = -c(postID.1, subreddit.1))

# Create training and testing sets
smp_size = floor(0.75 * nrow(reddit)); set.seed(123)
train_ind = sample(seq_len(nrow(reddit)), size = smp_size)
reddit[train_ind, 'validation'] =  'train'
reddit[-train_ind, 'validation'] =  'test'

# Substring commentParentID
reddit$commentParentID2 = with(reddit, sapply(commentParentID, function(x) substr(x, 4, nchar(x))))

# Time between when the post and comment were created
reddit$recency = rowSums(cbind(as.numeric(reddit$commentCreated), -as.numeric(reddit$postCreated)))

reddit$recencyMin = sapply(reddit$recency, function(x) x/60)
reddit$recencyHr = sapply(reddit$recency, function(x) x/60/60)

# Mark the levels of the comment chain
reddit$commentLevel = 'rootMore'
parentID = unique(reddit$postID)
i = 0

while(length(reddit[reddit$commentLevel == 'rootMore', 'commentLevel']) != 0) {
  reddit$commentLevel = ifelse(reddit$commentParentID2 %in% parentID, i, reddit$commentLevel)
  print(table(reddit$commentLevel))
  parentID = reddit[reddit$commentLevel == i, 'commentID']
  i = i + 1
}

reddit$commentLevel2 = sapply(as.numeric(reddit$commentLevel), function(x) x + 1)

# One vote vs. down vote vs. up vote
reddit$onevote = ifelse(reddit$commentScore == 1, 'Neutral', 
                        ifelse(reddit$commentScore < 1, 'Downvoted', 
                               ifelse(reddit$commentScore > 1, 'Upvoted', 'NA'))
                        )

# Number of characters
reddit$nchar = sapply(reddit$commentBody, nchar)

# Extreme upvotes and downvotes
extremeVotes = ddply(reddit, 'subreddit', summarise,
                     downvote = quantile(commentScore, .03),
                     upvote = quantile(commentScore, .97))

reddit = merge(reddit, extremeVotes, by = 'subreddit')

reddit$extremeVotes = ifelse(reddit$commentScore <= reddit$downvote, 0, ifelse(reddit$commentScore >= reddit$upvote, 1, NA))

### SAVED ### 02 reddit.RData 06/28/15 21:37
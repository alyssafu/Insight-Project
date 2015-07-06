reddit$commentBody2 = reddit$commentBody

# Recode HTML codes
reddit$commentBody2 = gsub("&gt;", ">", reddit$commentBody2)
reddit$commentBody2 = gsub("&lt;", "<", reddit$commentBody2)
reddit$commentBody2 = gsub("&amp;", "&", reddit$commentBody2)
reddit$commentBody2 = gsub("&nbsp;", " ", reddit$commentBody2)

# Remove deleted
reddit$commentBody2 = gsub("^[deleted]$", "", reddit$commentBody2)

# Remove URL
reddit$commentBody2 = gsub("http[[:alnum:][:punct:]]*", " ", reddit$commentBody2) # url

# Remove /r/subreddit, /u/user
reddit$commentBody2 = gsub("/r/[[:alnum:]]+|/u/[[:alnum:]]+", " ", reddit$commentBody2)

# Remove quoted comments
reddit$commentBody2 = gsub("(>.*?\\n\\n)+", " ", reddit$commentBody2)

# Remove control characters (\n, \b)
reddit$commentBody2 = gsub("[[:cntrl:]]", " ", reddit$commentBody2)

# Remove single quotation marks (contractions)
reddit$commentBody2 = gsub("'", "", reddit$commentBody2)

# Remove punctuation
reddit$commentBody2 = gsub("[[:punct:]]", " ", reddit$commentBody2)

# Replace multiple spaces with single space
reddit$commentBody2 = gsub("\\s+", " ", reddit$commentBody2) # Multiple spaces
reddit$commentBody2 = gsub("^\\s+", "", reddit$commentBody2) # Space at the start of the string
reddit$commentBody2 = gsub("+\\s$", "", reddit$commentBody2) # Space at the end of the string

# Lower case
reddit$commentBody2 = tolower(reddit$commentBody2)

# Number of words
reddit$commentLength = sapply(gregexpr("\\s+", reddit$commentBody2), length) + 1

### SAVED ### 02 reddit.RData 06/28/15 20:18
library('stringr')
library('data.table')

setwd('/Users/insightfu/Desktop/Insight/Insight Project/Week 4/regroup 2/')
afinn_list = read.delim(file = 'AFINN-111.txt', stringsAsFactors = FALSE)
names(afinn_list) = c('word', 'score')
afinn_list$word = tolower(afinn_list$word)

sentimentScore = function(comment) {
  wordList = str_split(comment, '\\s+'); wordList
  words = unlist(wordList); words
  
  wordMatches = match(words, afinn_list$word); wordMatches
  
  posRawScore = c()
  negRawScore = c()
  
  for(word in wordMatches) {
    score = afinn_list$score[word]
    if(!is.na(score) & score > 0) {
      posRawScore = c(posRawScore, score)
    } else if(!is.na(score) & score < 0) {
      negRawScore = c(negRawScore, score)
    }
  }; posRawScore; negRawScore
  
  posScore = sum(posRawScore, na.rm = T); posScore
  negScore = sum(negRawScore, na.rm = T); negScore
  sentScore = sum(posScore, negScore)
  
  return(c(posScore, negScore, sentScore))
}

reddit$posScore = sapply(reddit$commentBody2, sentimentScore)[1,]
reddit$negScore = sapply(reddit$commentBody2, sentimentScore)[2,]
reddit$sentScore = sapply(reddit$commentBody2, sentimentScore)[3,]

reddit$posNorm = mapply(function(x, y) x/y, x = reddit$posScore, y = reddit$commentLength)
reddit$negNorm = mapply(function(x, y) x/y, x = reddit$negScore, y = reddit$commentLength)
reddit$sentNorm = mapply(function(x, y) x/y, x = reddit$sentScore, y = reddit$commentLength)

reddit$posScorePost = sapply(reddit$postTitle2, sentimentScore)[1,]
reddit$negScorePost = sapply(reddit$postTitle2, sentimentScore)[2,]
reddit$sentScorePost = sapply(reddit$postTitle2, sentimentScore)[3,]

reddit$posNormPost = mapply(function(x, y) x/y, x = reddit$posScorePost, y = reddit$postLength)
reddit$negNormPost = mapply(function(x, y) x/y, x = reddit$negScorePost, y = reddit$postLength)
reddit$sentNormPost = mapply(function(x, y) x/y, x = reddit$sentScorePost, y = reddit$postLength)

### SAVED ### 02 reddit.RData 07/02/15 12:35
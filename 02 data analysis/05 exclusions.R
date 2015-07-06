reddit$exclude = 'keep'

# Remove posts where commentCreated < postCreated
summary(reddit$recency)
nrow(reddit[reddit$recency < 0,])
length(unique(reddit[reddit$recency < 0, 'postID']))

reddit$recencyRemove[reddit$postID %in% unique(reddit[reddit$recency < 0, 'postID'])] = 'remove'

# Set exclusions
reddit[reddit$postID %in% recencyRemove, 'exclude'] = 'exclude'
reddit[reddit$commentAuthor == 'None', 'exclude'] = 'exclude'

# Exclude deletions from comment body (e.g., [deleted], bots)
reddit[grep('^[deleted]$', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('If you have any questions about this removal', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('jump to content', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('TotesMessenger', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('\\Q[Problems/Bugs?]\\E', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('\\Q[^[Contact ^creator]]\\E', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('\\Q[Source: karmadecay]\\E', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('Thank you for subscribing to', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('^Anyone seeking more info might also check here', reddit$commentBody), 'exclude'] = 'exclude'
reddit[grep('^$', reddit$commentBody), 'exclude'] = 'exclude'

reddit[reddit$sentScore %in% c(-6210, -732), 'exclude'] = 'exclude'

### SAVED ### 02 reddit.RData 06/28/15 20:56
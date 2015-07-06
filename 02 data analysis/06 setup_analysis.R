redditKeep = subset(reddit, reddit$exclude == 'keep')
redditTrain = subset(redditKeep, redditKeep$validation == 'train')
redditTest = subset(redditKeep, redditKeep$validation == 'test')

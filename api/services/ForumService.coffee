module.exports = 

  getSections: ->
    ForumSection.find()
    
  getThreads: (sectionId, limit = null, offset = null) ->
    ForumThread.find({ section: sectionId })
    
  getPosts: (threadId, limit = null, offset = null) ->
    ForumThread.find({ thread: threadId })

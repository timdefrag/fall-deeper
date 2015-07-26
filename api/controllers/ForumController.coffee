cfg = sails.config.trance.forum

module.exports =
  
  sections: (req, res) ->
    ForumService
      .getSections()
      .then util.resOk(res)
      .fail util.resErr(res)
    
  threads: (req, res) ->
    util
      .getPayload(req)
      .then (payload) ->
        {limit,offset} = util.pageLimitOffset(payload.page, cfg.threadsPerPage)
        ForumService.getThreads(payload.sectionId, limit, offset)
      .then util.resOk(res)
      .fail util.resErr(res)
    
  posts: (req, res) ->
    util
      .getPayload(req)
      .then (payload) ->
        {limit,offset} = util.pageLimitOffset(payload.page, cfg.postsPerPage)
        ForumService.getPosts(payload.sectionId, limit, offset)
      .then util.resOk(res)
      .fail util.resErr(res)
  
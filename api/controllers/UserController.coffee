module.exports =

  connect: (req, res) ->
    nick = null
    util
      .getPayload req
      .then (params) ->
        nick = params.nick
        if params.session
          User.findOne { session: params.session }
        else
          User.findOne { nick: nick }
      .then (user) ->
        req.session.user = user
        session.key
      .then util.resOk(req)
      .fail util.resErr(req)
  
  disconnect: (req, res) ->
    util
      .getPayload req
      .then (params) ->
        if params.session
          User.findOne { session: params.session }
        else
          throw { code: 'session-not-found' }
      .then util.resOk(req)
      .fail util.resErr(req)
      
      
ns = 'api/controllers/UserController.coffee'

module.exports =

  connect: (req, res) ->
    fn = 'connect'
    nick = null
    util
      .getPayload req
      .then (params) ->
        nick = params.nick
        util.log ns, fn, 'nick =', params.nick
        if params.session
          util.log ns, fn, 'looking up user by session key:', params.session
          User.findOne { session: params.session }
        else
          util.log ns, fn, 'looking up user by nick:', params.nick
          User.findOne { nick: nick }
      .then (user) ->
        if !user
          util.log ns, fn, 'user not found, creating user for nick:', nick
          User.create { nick: nick }
        else
          user
      .then (user) ->
        req.session.user = user
        user
      .then util.resOk(res)
      .fail util.resErr(res)
  
  disconnect: (req, res) ->
    util
      .getPayload req
      .then (params) ->
        if params.session
          User.findOne { session: params.session }
        else
          throw { code: 'session-not-found' }
      .then util.resOk(res)
      .fail util.resErr(res)
      
      
module.exports = (req, res, next) ->
  if(!req.session.user)
    util.resErr(req)({ code: 'must-be-user' })
  else
    next()
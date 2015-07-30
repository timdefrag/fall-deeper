module.exports = (req, res, next) ->
  user = req.session.user
  if(!user || !user.admin)
    util.resErr(req)({ code: 'must-be-admin' })
  else
    next()
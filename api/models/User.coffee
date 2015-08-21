ns = 'api/models/User.coffee'

uuid = require 'uuid'

module.exports =
  attributes:
    session:
      type: 'string'
    nick:
      type    : 'string'
      unique  : true
    account:
      model       : 'Account'
      defaultsTo  : null
    admin:
      type        : 'boolean'
      defaultsTo  : false
      
  beforeCreate: (values, cb) ->
    fn = 'beforeCreate'
    values.session = uuid.v4()
    cb()
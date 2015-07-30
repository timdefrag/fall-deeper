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
    
Q = require 'q'

module.exports =

  log: (ns, fn, values...) ->
    values.unshift '[' + ns + '] ' + fn + ':'
    sails.log.apply sails, values

  getPayload: (req, opts) -> 
    opts = _.defaults(opts || {}, {
      param     : 'payload',
      nullable  : false
    })
    payload = req.param(opts.param)
    return Q.fcall ->
      if(payload || opts.nullable)
        return payload;
      throw { code: 'bad-request', message: 'payload-required' }

  resOk: (res) -> 
    (data) ->
      res.send { status: 'ok', data: data }

  resErr: (res) ->
    (err) ->
      sails.log('sending error:', err);
      res.send
        status:   'err',
        code:     err.code || 'unhandled-exception',
        message:  err.message || null,
        data:     err.data || null
        
  pageLimitOffset: (page, perPage) ->
    { limit: perPage, offset: (page * perPage) }
do =>
  
  tn.util = {}
  
  tn.util.request = (method, endpoint, payload) ->
    dfd = Q.defer()
    io.socket[method](endpoint, { payload: payload }, (result, res) ->
      if !result || !(result.status == 'ok' || result.status == 'err')
        dfd.reject { code: 'unexpected-response', message: null, data: result }
      else if result.status == 'err'
        dfd.reject(result)
      else
        dfd.resolve(result.data)
    )
    dfd.promise
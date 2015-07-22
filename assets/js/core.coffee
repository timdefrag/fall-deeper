do ->
  window.tn = {}
  
  initFns = []
  
  init = ->
    _.each(initFns, (fn) -> fn())
  
  $(init)
  
  tn.core = {}
  
  tn.core.onInit = (fn) ->
    initFns.push(fn)
do ->
  window.tn = {}
  
  initFns = []
  viewStates = {}
  
  init = ->
    _.each(initFns, (fn) -> fn())
    ko.applyBindings()
  
  $(init)
  
  tn.core = {}
  
  tn.core.onInit = (fn) ->
    initFns.push(fn)
    
  tn.core.registerView = (name, controller) ->
    states = viewStates[name] = {};
    factory = (params, componentInfo) ->
      params = _.defaults (params || {}),
        persist:  null
        notify:   null
      view = null;
      if params.persist
        view = states[params.persist] || null
      if !view
        view = new controller()
        if params.notify
          params.notify(view)
      if params.persist
        states[params.persist] = view
      if view.onClose
        view.dispose = view.onClose
      if view.onOpen
        view.onOpen()
      return view
    ko.components.register name, 
      template   : JST['assets/templates/' + name + '.html']()
      viewModel  : { createViewModel: factory }
      
  
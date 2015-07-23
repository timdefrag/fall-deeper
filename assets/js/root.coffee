do ->

  navs =
    chat   : { view: 'chat'   , label: 'Chat'   }
    forum  : { view: 'forum'  , label: 'Forum'  }

  class RootController
    constructor: ->
      @allNavs    = ko.observableArray([navs.chat, navs.forum])
      @activeNav  = ko.observable(navs.chat)
      
      # TODO: Implement an actual resize cascade.
      $window = $(window)
      @onResize($window.width(), $window.height())
    
    setNav: (nav) =>
      @activeNav nav
      
    onResize: (w, h) ->
      $navbar = $('.root-navbar')
      console.log $navbar.height()
      $body = $('.root-body')
      $navbar.width(w)
      $body.width(w)
      $body.height(h - $navbar.height())
      
  
  tn.core.registerView 'root', RootController
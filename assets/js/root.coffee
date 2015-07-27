do ->

  navs =
    chat   : { view: 'chat'   , label: 'Chat'   }
    forum  : { view: 'forum'  , label: 'Forum'  }
    admin  : { view: 'admin'  , label: 'Admin'  }

  class RootController
    constructor: ->
      @allNavs      = ko.observableArray([navs.chat, navs.forum, navs.admin])
      @activeNav    = ko.observable(navs.chat)
      @contentView  = null
      @lastSize     = { w: 300, h: 300 }
      
      # TODO: Implement an actual resize cascade.
      $window = $(window)
      @onResize($window.width(), $window.height())
    
    setContentView: (view) =>
      @contentView = view
      @onResize(@lastSize.w, @lastSize.h)
    
    setNav: (nav) =>
      @activeNav nav
      
    onResize: (w, h) ->
      @lastSize.w = w
      @lastSize.h = h
      $navbar = $('.root-navbar')
      $body = $('.root-body')
      $navbar.width(w)
      $body.width(w)
      $body.height(h - $navbar.height())
      if @contentView && @contentView.onResize
        @contentView.onResize(w, h - $navbar.height())
      
  tn.core.registerView 'root', RootController
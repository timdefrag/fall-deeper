do ->

  navs =
    general  : { view: 'admin-general'  , label: 'General'  }
    forum    : { view: 'admin-forum'    , label: 'Forum'    }

  class AdminController
    constructor: ->
      @allNavs      = ko.observableArray([navs.general, navs.forum])
      @activeNav    = ko.observable(navs.general)
      @contentView  = null
      @lastSize     = { w: 0, h: 0 }
      
    onResize: (w, h) =>
      $navbar = $('.admin-navbar')
      $body = $('.admin-body')
      $navbar.height(h)
      $body.height(h)
      $body.width(w - $navbar.width())
      if @contentView && @contentView.onResize
        @contentView.onResize(w - $navbar.width(), h)
      
    setNav: (nav) =>
      @activeNav nav
      
    setContentView: (view) =>
      @contentView = view
      @onResize(@lastSize.w, @lastSize.h)
      
  tn.core.registerView 'admin', AdminController
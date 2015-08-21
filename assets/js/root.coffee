do ->

  tn.root = {}

  tn.root.navs =
    chat   : { view: 'chat'   , label: 'Chat'   }
    forum  : { view: 'forum'  , label: 'Forum'  }
    admin  : { view: 'admin'  , label: 'Admin'  }
    
  tn.root.RootController = class RootController
    constructor: ->
      navs = tn.root.navs
    
      @user         = ko.observable null
      @connected    = ko.observable false
      @nick         = ko.observable ''
      @pass         = ko.observable ''
      @allNavs      = ko.observableArray [navs.chat, navs.forum, navs.admin]
      @activeNav    = ko.observable navs.chat
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
        
    connect: ->
      payload = 
        nick: @nick()
        pass: @pass()
      if @user
        payload.session = @user.session
      tn.util
        .request 'post', '/user/connect', payload
        .then (user) =>
          console.log 'you logged in son. session key:', user.session
          @user user
        .fail (err) ->
          console.log 'connect failed:', err
    
    disconnect: ->
      tn.util
        .request 'post', '/user/disconnect'
        .then ->
          console.log 'logged out'
          @user = null
        .fail (err) ->
          console.log 'logout failed you fucking idiot:', err
      
  tn.core.registerView 'root', RootController
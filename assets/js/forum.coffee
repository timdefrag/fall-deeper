do ->
  
  tn.forum = {}
  
  tn.forum.loadSections = ->
    tn.util.request 'get', 'forum/sections'
  
  class ForumController
    constructor: ->
      @loading = ko.observable false
      @rootBrowserView = null
      @activeBrowserView = null
      @activeThreadView = null
      
      @loadSections()
      
    loadSections: ->
      @loading true
      tn.forum
        .loadSections()
        .fin => @loading false
        .then (sections) =>
          console.log 'got sections:', sections
        .fail (err) =>
          console.log 'got error:', err
          throw err
      
  tn.core.registerView 'forum', ForumController
do ->

  tn.chat = {}

  tn.chat.ChatController = class ChatController
    constructor: ->
      @initListeners()
      
    initListeners: ->
      io.socket.on 'chatRoom', @onChatRoomEvent
        
    onChatRoomEvent: (event) ->
      null
      
    
      
    
      
  tn.core.registerView 'chat', ChatController
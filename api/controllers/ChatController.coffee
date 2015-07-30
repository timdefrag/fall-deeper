module.exports =

  join: (req, res) ->
    slug = null
    util
      .getPayload req
      .then (s) ->
        slug = s
        ChatRoom.findOne { slug: slug }
      .then (room) ->
        if !room
          throw { code: 'room-not-found', data: { slug: slug } }
        # TODO: Check if current user is allowed to join this room.
        ChatRoom.subscribe req, [room.id]
      .then util.resOk(req)
      .fail util.resErr(req)
    
  leave: (req, res) ->
    slug = null
    util
      .getPayload req
      .then (s) ->
        slug = s
        ChatRoom.findOne { slug: slug }
      .then (room) ->
        if !room
          throw { code: 'room-not-found', data: { slug: slug } }
        # TODO: Check if current user is in this room.
        ChatRoom.unsubscribe req, room
      .then util.resOk(req)
      .fail util.resErr(req)
    
  message: (req, res) ->
    null
  
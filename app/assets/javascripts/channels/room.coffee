App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	$('#messages').append data['message']

  speak: (message) ->
    @perform 'speak', message: message

  # check when a key is pressed on client-side, and if that key is the return key,
  # then send the data in the text-field to the room.speak (or where the text will show up)
  # and reset the text-field to ''
$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ""
    event.preventDefault()
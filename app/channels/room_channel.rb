# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
    # When streaming something, it is called by 'received: (data)' on client side
    def subscribed
        stream_from 'room_channel'
    end

    def unsubscribed
        # Any cleanup needed when channel is unsubscribed
    end

    def speak(data)
        Message.create! content: data['message'], user: current_user
        # ActionCable.server.broadcast 'room_channel', message: data['message']
    end
end

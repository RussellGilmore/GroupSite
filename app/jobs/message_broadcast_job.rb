class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'room_channel', message: render_message(message)
  end

  # Want somebody on client-side to call App.room.speak and that gets sent up to channel, the channel makes
  # record to database, then calls this job, then render the partial html for message, then send back
  private
    def render_message(message)
    	ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end
end

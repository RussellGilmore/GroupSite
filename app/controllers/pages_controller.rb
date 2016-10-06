class PagesController < ApplicationController
  def forum
  end

  def text_chat
  	@messages = Message.all
  end

  def drive
  end

  def video_chat
  end
end

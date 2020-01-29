class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
  	ActionCable.server.broadcast "room_channel_#{chat.room_id}", chat: render_chat(chat)
    # Do something later
  end

  private
  	def render_chat(chat)
  		AppricationController.render.render partial: 'chat/chat',locals: {chat: chat}
  	end
end

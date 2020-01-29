class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
  	ActionCable.server.broadcast "room_channel_#{chat.room_id}", chat: render_chat(chat)
    # Do something later
  end

  private
  	def render_chat(chat)
  		AppricationController.renderer.render partial: 'chats/chat',locals: {chat: chat}
  	end
end

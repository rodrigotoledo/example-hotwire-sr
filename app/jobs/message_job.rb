class MessageJob < ApplicationJob
  queue_as :default
  include CableReady::Broadcaster

  def perform(message)
    cable_ready["messages"].morph(
      selector: "#room_#{message.room_id} .messages_count",
      html: message.room.messages.count
    ).broadcast_to(message)
  end
end

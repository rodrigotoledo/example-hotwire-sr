class Message < ApplicationRecord
  include CableReady::Broadcaster
  belongs_to :room
  after_create_commit do
    broadcast_append_to "messages_#{self.room_id}", target: "messages_#{self.room_id}"
    broadcast_update_to "messages", target: "count_message_#{self.room_id}", html: self.room.messages.count
  end
  after_update_commit { broadcast_replace_to "messages", target: "message_#{self.id}"  }
  after_destroy_commit do
    broadcast_remove_to "messages", target: "message_#{self.id}"
    broadcast_update_to "messages", target: "count_message_#{self.room_id}", html: self.room.messages.count
  end
end

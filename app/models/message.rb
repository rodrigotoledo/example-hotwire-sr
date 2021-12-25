class Message < ApplicationRecord
  include CableReady::Broadcaster
  belongs_to :room
  belongs_to :user
  after_create_commit do
    broadcast_append_later_to "messages_#{self.room_id}", target: "messages_#{self.room_id}", locals: { user: self.user }
    broadcast_update_later_to "messages", target: "count_message_#{self.room_id}", html: self.room.messages.count, locals: { user: self.user }
  end
  after_update_commit { broadcast_replace_to "message_#{self.id}", target: "message_#{self.id}", locals: { user: self.user }  }
  after_destroy_commit do
    broadcast_remove_to "messages", target: "message_#{self.id}", locals: { user: self.user }
    broadcast_update_to "messages", target: "count_message_#{self.room_id}", html: self.room.messages.count, locals: { user: self.user }
  end
end

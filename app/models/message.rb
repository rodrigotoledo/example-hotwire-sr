class Message < ApplicationRecord
  include CableReady::Broadcaster
  belongs_to :room
  after_create_commit do
    broadcast_append_to "messages", target: "messages"
    cable_ready["messages"].morph(
      selector: "#testing",
      html: self.room.messages.count
    ).broadcast
  end
  after_update_commit { broadcast_replace_to "messages", target: "message_#{self.id}"  }
  after_destroy_commit { broadcast_remove_to "messages", target: "message_#{self.id}"  }
end

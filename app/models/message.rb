class Message < ApplicationRecord
  belongs_to :room
  after_create_commit { broadcast_append_to "messages", target: "messages" }
  after_update_commit { broadcast_replace_to "messages", target: "message_#{self.id}"  }
  after_destroy_commit { broadcast_remove_to "messages", target: "message_#{self.id}"  }
end

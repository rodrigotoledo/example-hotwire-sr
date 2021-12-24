class Room < ApplicationRecord
  has_many :messages
  after_create_commit { broadcast_append_to "chat_rooms", target: "chat_rooms" }
  after_update_commit { broadcast_replace_to "chat_rooms", target: "room_#{self.id}"  }
  after_destroy_commit { broadcast_remove_to "chat_rooms", target: "room_#{self.id}"  }
end

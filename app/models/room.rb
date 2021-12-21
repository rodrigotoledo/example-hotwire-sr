class Room < ApplicationRecord
  has_many :messages
  after_create_commit { broadcast_append_to "chat_rooms", target: "chat_rooms" }
end

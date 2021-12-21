json.extract! message, :id, :room_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)

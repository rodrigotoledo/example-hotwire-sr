module MessagesHelper

  def align_by_current_user(message, user)
    'text-end' if user.id == message.user_id
  end
end

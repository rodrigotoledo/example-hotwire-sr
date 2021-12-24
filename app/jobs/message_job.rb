class MessageJob < ApplicationJob
  queue_as :default
  # include CableReady::Broadcaster

  def perform(message)
  end
end

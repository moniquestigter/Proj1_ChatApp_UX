class Mensaje < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :body, presence: true

  after_create_commit do
  	NotifyBroadcastJob.perform_later(self)
  end
end

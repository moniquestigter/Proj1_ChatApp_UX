class Chat < ApplicationRecord
	belongs_to :sender, class_name: 'User'
	belongs_to :recipient, class_name: 'User'

	validates :sender, uniqueness: {scope: :recipient}

	has_many :mensajes, -> {order(created_at: :asc)}, dependent: :destroy

	scope :participating, -> (user) do 
		where("(chats.sender_id = ? OR chats.recipient_id = ?)", user.id, user.id)
	end

	scope :between, -> (sender_id, recipient_id) do
		where(sender_id: sender_id, recipient_id: recipient_id).or(where(sender_id: recipient_id, recipient_id: sender_id)).limit(1)
	end

	def with(current_user)
		sender == current_user ? recipient : sender
	end

	def participates?(user)
		sender == user || recipient == user
	end
end



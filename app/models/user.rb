class User < ApplicationRecord
	extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :sender_chats, class_name: 'Chat', foreign_key: 'sender_id'
   has_many :recieved_chats, class_name: 'Chat', foreign_key: 'recipient_id'
   has_many :mensajes, dependent: :destroy


  def name
  	email.split('@')[0]
  end
end

class NotifyChannel < ApplicationCable::Channel
  def subscribed
    stream_from ("notify_#{current_user.id}_channel")
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def enviar_mensaje(data)
    chat = Chat.find_by(id: data['chat_id'])
    if chat && chat.participates?(current_user)
      mensaje = current_user.mensajes.build({body: data['mensaje']})
      mensaje.chat = chat
      mensaje.save!
    end
  end
end

class NotifyBroadcastJob < ApplicationJob
 queue_as :default

  def perform(mensaje)
    mensaje = render_mensaje(mensaje)

    ActionCable.server.broadcast "notify_#{mensaje.user.id}_channel", mensaje: mensaje, chat_id: mensaje.chat.id

    if mensaje.recipient.online?
      ActionCable.server.broadcast "notify_#{mensaje.recipient.id}_channel",
                                   notification: render_noti(mensaje),
                                   mensaje: mensaje,
                                   chat_id: mensaje.chat.id
    end
  end

  private

  def render_noti(mensaje)
    NotifyController.render partial: 'notifications/notification', locals: {mensaje: mensaje}
  end

  def render_mensaje(mensaje)
    MensajesController.render partial: 'mensajes/mensaje',
                                      locals: {mensaje: mensaje}
  end

end

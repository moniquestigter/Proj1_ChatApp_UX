class MensajesController < ApplicationController
	before_action :buscar_convo!

	def new
		redirect_to chat_path(@chat) and return if @chat
		@mensaje = current_user.mensajes.build
	end

	def create
		@chat ||= Chat.create(sender_id: current_user.id, recipient_id: @recipient.id)
		@mensaje = current_user.mensajes.build(mensaje_params)
		@mensaje.chat_id = @chat.id
		@mensaje.save!

		flash[:success] = "Enviado"
		redirect_to chat_path(@chat)
	end

	private

	def mensaje_params
		params.require(:mensaje).permit(:body)
	end

	  def buscar_convo!
	  if params[:recipient_id]
    	@recipient = User.find_by(id: params[:recipient_id])
    	redirect_to(root_path) and return unless @recipient
    	@chat = Chat.between(current_user.id, @recipient.id)[0]
  	  else
    	@chat = Chat.find_by(id: params[:chat_id])
    	redirect_to(root_path) and return unless @chat && @chat.participates?(current_user)
	end
  end
end

class ChatsController < ApplicationController
	  before_action :set_chat, except: [:index]
  	before_action :check_participantes!, except: [:index]
	
  def index
  	@chats = Chat.participating(current_user).order('updated_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  	@chat = Chat.find_by(id: params[:id])
  	@mensaje = Mensaje.new
  end

  private

  def set_chat
  	@chat = Chat.find_by(id: params[:id])
  end

  def check_participantes!
  	redirect_to root_path unless @chat && @chat.participates?(current_user)
  end

end

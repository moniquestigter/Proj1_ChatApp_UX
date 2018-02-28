module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_user

  	def connect
  		self.current_user = buscar_ver_user
  		logger.add_tags 'ActionCable', current_user.email
  	end

  	protected

  	def buscar_ver_user 
  		ver_user = env['warden'].user
  		if ver_user
  			ver_user
  		else
  			reject_unauthorized_connection
  		end
  	end
  end

end

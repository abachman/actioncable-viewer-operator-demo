module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_chat_session

    def connect
      self.current_chat_session = find_verified_chat_session
    end

    private

    def find_verified_chat_session
      logger.info "[find_verified_chat_session] checking cookies for :session_id => #{cookies.encrypted[:chat_session_id]}"
      if verified_chat_session = ChatSession.find_by(id: cookies.encrypted[:chat_session_id])
        verified_chat_session
      else
        logger.error "[find_verified_chat_session] rejecting!"
        reject_unauthorized_connection
      end
    end
  end
end

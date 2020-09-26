module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_signing_session

    def connect
      self.current_signing_session = find_verified_signing_session
    end

    private

    def find_verified_signing_session
      if verified_signing_session = SigningSession.find_by(id: cookies.encrypted[:signing_session_id])
        verified_signing_session
      else
        reject_unauthorized_connection
      end
    end
  end
end

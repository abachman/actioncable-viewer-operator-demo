module ConnectionStatusHelper
  def connection_status
    {
      status: {
        viewer: current_chat_session.viewer_state == 'connected',
        operator: current_chat_session.operator_state == 'connected'
      },
      identity: {
        viewer: current_chat_session.token,
        operator: current_chat_session.operator&.email
      }
    }
  end
end

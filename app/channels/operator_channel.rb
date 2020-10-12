class OperatorChannel < ApplicationCable::Channel
  include ConnectionStatusHelper
  attr_accessor :check_id

  def subscribed
    logger.debug 'OperatorChannel#subscribed'

    stream_for current_chat_session
    current_chat_session.connect_operator!

    transmit(connection_status)
    ViewerChannel.broadcast_to(current_chat_session, connection_status)
  end

  def unsubscribed
    logger.debug 'OperatorChannel#unsubscribed'

    current_chat_session.disconnect_operator!

    ViewerChannel.broadcast_to(current_chat_session, connection_status)
  end

  def send_message(data)
    ViewerChannel.broadcast_to(
      current_chat_session,
      { type: 'message', payload: data }
    )
  end
end

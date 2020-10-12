class ViewerChannel < ApplicationCable::Channel
  include ConnectionStatusHelper

  def subscribed
    logger.debug 'ViewerChannel#subscribed'

    stream_for current_chat_session
    current_chat_session.connect_viewer!
    transmit(connection_status)
    OperatorChannel.broadcast_to(current_chat_session, connection_status)
  end

  def unsubscribed
    logger.debug 'ViewerChannel#unsubscribed'

    current_chat_session.disconnect_viewer!
    OperatorChannel.broadcast_to(current_chat_session, connection_status)
  end

  def confirm
    OperatorChannel.broadcast_to(current_chat_session, { type: 'confirm' })
  end

  private
end

class ChatSessionsController < ApplicationController
  before_action :prepare_chat_session, only: %i[new]
  before_action :load_chat_session, only: %i[destroy]

  def new
    logger.info "[ChatSessions#new] setting session_id to #{@chat_session.id}"
  end

  def destroy
    @chat_session.destroy!
    cookies.delete(:chat_session_id)
    redirect_to root_path
  end

  private

  def load_chat_session
    @chat_session = ChatSession.find_by(id: cookies.encrypted[:chat_session_id])
  end

  def prepare_chat_session
    if cookies.encrypted[:chat_session_id]
      @chat_session =
        ChatSession.find_by(id: cookies.encrypted[:chat_session_id])
    else
      @chat_session = ChatSession.create(active: true)
      cookies.encrypted[:chat_session_id] = @chat_session.id
    end
  end
end

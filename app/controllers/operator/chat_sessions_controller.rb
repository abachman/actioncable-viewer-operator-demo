class Operator::ChatSessionsController < OperatorController
  def index
    @chat_sessions = ChatSession.all
  end

  def show
    @chat_session =
      ChatSession.find_by(id: params[:id], operator: current_operator)

    if @chat_session.nil?
      redirect_to operator_path,
                  alert: 'You are not operating a session with that ID'
      return
    end

    ViewerChannel.broadcast_to(
      @chat_session,
      message: "#{current_operator.email} has connected"
    )
  end

  def create
    logger.info 'Operator::ChatSessionsController create!!'

    @chat_session =
      ChatSession.find_by(token: params[:chat_session][:token], operator: nil)

    if @chat_session.present?
      @chat_session.update(operator: current_operator)
      cookies.encrypted[:chat_session_id] = @chat_session.id
      redirect_to operator_chat_session_path(@chat_session)
    else
      redirect_to operator_path,
                  alert: 'Could not find a viewer with that token :('
    end
  end

  def disconnect
    @chat_session =
      ChatSession.find_by(id: params[:id], operator: current_operator)
    @chat_session.update(operator: nil)
    ViewerChannel.broadcast_to(
      @chat_session,
      message: "#{current_operator.email} has disconnected"
    )
    redirect_to operator_path, notice: 'Disconnected from chat session'
  end

  def destroy
    @chat_session.destroy!
    cookies.encrypted.delete(:chat_session_id)
    redirect_to root_path
  end

  private
end

# Operator authentication
class Operator::SessionsController < OperatorController
  skip_before_action :require_operator!, only: %i[new create]

  def new; end

  def create
    user = Operator.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      session[:operator_id] = user.id.to_s
      redirect_to operator_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = 'Sorry, you do not have access to this resource.'
      render :new
    end
  end

  def destroy
    session.delete(:operator_id)
    redirect_to operator_login_path, notice: 'Logged out!'
  end

  private

  def login_params
    params.require(:operator_login).permit(:email, :password)
  end # delete the saved user_id key/value from the cookie:
end

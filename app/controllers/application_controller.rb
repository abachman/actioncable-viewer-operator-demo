class ApplicationController < ActionController::Base
  def current_operator
    if session[:operator_id]
      @current_operator ||= Operator.find(session[:operator_id])
    end
  end #

  helper_method :current_operator

  def prevent_when_signed_in
    if current_operator.present?
      redirect_to operator_path,
                  alert: "Sorry, you can't do that while you're signed in"
    end
  end
end

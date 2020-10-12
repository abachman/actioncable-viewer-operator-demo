class OperatorController < ApplicationController
  before_action :require_operator!
  layout 'operator'

  def index; end

  def require_operator!
    if current_operator.nil?
      redirect_to(
        operator_login_path,
        flash: { error: 'You do not have access to this resource' }
      )
    end
  end
end

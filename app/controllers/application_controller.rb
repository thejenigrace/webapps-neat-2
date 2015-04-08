class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.where(id: session[:user_id]).first
  end

  def current_user_transaction
    Transaction.where(user_id: session[:user_id]).first
  end

  private

  def require_login
    redirect_to sessions_login_path if session[:user_id].nil?
  end
end

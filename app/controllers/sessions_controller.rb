class SessionsController < ApplicationController
  skip_before_action :require_login, except: :logout

  def index
    if session[:user_id]
      redirect_to home_path
    end
  end

  def login
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to home_path
    else
      redirect_to action: :index
    end
  end

  def logout
      session[:user_id] = nil
      redirect_to action: :index
  end

  def register
      confirm_token = SecureRandom.urlsafe_base64.to_s
      user = User.create_user(params[:name], params[:email], params[:password], params[:password_confirm], confirm_token)

    if user
      # deliver the account confirmation email
      UserMailer.registration_confirmation(user).deliver
      session[:user_id] = user.id

      redirect_to sessions_confirmation_path
    else
      session[:user_id] = nil
      redirect_to action: :index
    end
  end

  def confirmation
    @current_user = current_user
  end

  def confirm_email
    user = current_user
    if (params[:confirm_token] == user.confirm_token)
      user.update_column(:email_confirmed, true)
    end
    redirect_to action: :index
  end
end
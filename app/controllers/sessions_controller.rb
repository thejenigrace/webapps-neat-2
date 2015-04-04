class SessionsController < ApplicationController
  skip_before_action :require_login, except: :logout

  def index
    if session[:user_id]
      redirect_to root_path
    end
  end

  def login
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to action: :index
    end
  end

  def logout
      session[:user_id] = nil
      redirect_to action: :index
  end

  def register
    if (params[:name].present? && params[:username].present? && params[:password].present? && params[:password_confirm].present?)
      user = User.create_user(params[:name], params[:email], params[:password], params[:password_confirm])
      puts 'create_user'
    end
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to action: :index
    end
  end
end
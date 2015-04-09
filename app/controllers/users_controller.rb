class UsersController < ApplicationController
  before_action :require_login

  def index
    if session[:user_id]
      @user = current_user

      if @user.email_confirmed
        @my_plans = Transaction.where(user_id: session[:user_id]).all
      else
        redirect_to sessions_confirmation_path
      end
    end
  end

  def avail_plan
    transaction = Transaction.new
    transaction.user_id = current_user.id
    transaction.plan_id = current_user_plan(params[:name]).id
    transaction.start_date = params[:start_date]
    transaction.end_date = params[:end_date]

    if(current_user.billing_address != nil)
      # save transaction to the database
      transaction.save

      # deliver the avail plan confirmation email
      UserMailer.avail_plan_confirmation(current_user, current_user_plan(params[:name]), transaction).deliver
    end

    redirect_to home_path
  end

  def cancel_plan
    transaction = Transaction.where(user_id: session[:user_id], plan_id: params[:plan_id]).first
    transaction.update_column(:user_id, -session[:user_id])

    redirect_to home_path
  end

  def edit_user_info

    if params[:new_name] != nil
      current_user.update_column(:name, params[:new_name])
    end

    if params[:new_billing_address] != nil
      current_user.update_column(:billing_address, params[:new_billing_address])
    end

    redirect_to home_path
  end

end

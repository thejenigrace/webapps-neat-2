class UsersController < ApplicationController
  before_action :require_login

  def index
    if session[:user_id]
      @user = current_user

      if @user.email_confirmed
        dateToday = Date.today.strftime('%m/%d/%Y')
        @my_transactions = Transaction.where('end_date >= ?', dateToday).where(user_id: session[:user_id]).all

        @plan1 = Plan.where(id: 1).first
        @plan2 = Plan.where(id: 2).first
        @plan3 = Plan.where(id: 3).first
        @plan4 = Plan.where(id: 4).first
        @plan5 = Plan.where(id: 5).first
        @plan6 = Plan.where(id: 6).first
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
    dateToday = Date.today.strftime('%m/%d/%Y')

    if(current_user.billing_address != nil)

      if(transaction.start_date < dateToday || transaction.start_date > transaction.end_date)

      else
        # save transaction to the database
        transaction.save

        # deliver the avail plan confirmation email
        UserMailer.avail_plan_confirmation(current_user, current_user_plan(params[:name]), transaction).deliver_now
      end
    end

    redirect_to home_path
  end

  def cancel_plan
    transaction = Transaction.where(user_id: session[:user_id], plan_id: params[:plan_id]).first
    transaction.update_column(:user_id, -session[:user_id])

    # deliver the cancel plan confirmation email
    UserMailer.cancel_plan_confirmation(current_user, current_user_plan_by_id(params[:plan_id]), transaction).deliver_now

    redirect_to home_path
  end

  def edit_user_info

    if params[:new_name] != nil
      if(params[:new_name] != "")
        current_user.update_column(:name, params[:new_name])
      end
    end

    if params[:new_billing_address] != nil
      if(params[:new_billing_address] == "")
        current_user.update_column(:billing_address, nil)
      else
        current_user.update_column(:billing_address, params[:new_billing_address])
      end
    end

    redirect_to home_path
  end

end

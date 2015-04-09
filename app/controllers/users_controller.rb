class UsersController < ApplicationController
  before_action :require_login

  def index
    if session[:user_id]
      @user = current_user

      # user = User.where(id: session[:user_id]).first
      if @user.email_confirmed
        # if @current_user.plan_id != nil
        #   @user_plan = Plan.where(id: @current_user.plan_id).first
        # else
        #   @user_plan = Plan.new
        #   @user_plan.duration = "Doesn't have a plan yet"
        # end
      else
        redirect_to sessions_confirmation_path
      end
    end
  end

  def avail_plan
    # if current_user.plan_id.nil?
    #   plan = Plan.new
    #   plan.name = params[:name]
    #   plan.price = params[:price]
    #   plan.duration = params[:duration]
    #   plan.user_id = session[:user_id]
    #
    #   if(plan.name.present? && plan.price.present? && plan.duration.present?)
    #     # save plan to the database
    #     plan.save
    #
    #     # save the plan_id to the user
    #     current_user.update_column(:plan_id, plan.id)
    #
    #     # deliver the avail plan confirmation email
    #     UserMailer.avail_plan_confirmation(current_user, plan).deliver
    #   end
    # else
    #   change_current_plan = Plan.where(user_id: current_user.id).first
    #   change_current_plan.update(name: params[:name], price: params[:price], duration: params[:duration])
    #
    #   # deliver the avail plan confirmation email
    #   UserMailer.avail_plan_confirmation(current_user, change_current_plan).deliver
    # end

    # temporary

    transaction = Transaction.new
    transaction.user_id = current_user.id
    transaction.plan_id = current_user_plan(params[:name]).id
    transaction.start_date = params[:startdate]
    transaction.end_date = params[:enddate]

    if(current_user.billing_address != nil)
      transaction.save
    end

    redirect_to home_path
  end

  def cancel_plan

  end

  def edit_user_info
    # current_user.update_column(:billing_address, params[:newbillingaddress])
  end
end

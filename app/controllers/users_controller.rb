class UsersController < ApplicationController
  before_action :require_login

  def index
    if session[:user_id]
      @current_user = current_user
      # user = User.where(id: session[:user_id]).first
      if @current_user.email_confirmed

      else
        redirect_to sessions_confirmation_path
      end
    end
  end

  def avail_plan
    plan = Plan.new
    plan.name = params[:name]
    plan.price = params[:price]
    plan.duration = params[:duration]
    plan.user_id = session[:user_id]

    if(plan.name.present? && plan.price.present? && plan.duration.present?)
      # save plan to the database
      plan.save

      # save the plan_id to the user
      current_user.update_column(:plan_id, plan.id)
    end

    redirect_to home_path
  end

  def cancel_plan

  end
end

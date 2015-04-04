class UsersController < ApplicationController
  before_action :require_login

  def index
    @current_user = current_user

  end

  def avail_plan
    plan = Plan.new
    plan.name = params[:name]
    plan.price = params[:price]
    plan.duration = params[:duration]
    plan.user_id = session[:user_id]

    if(plan.name.present? && plan.price.present? && plan.duration.present?)
      plan.save

      current_user_edit = current_user
      current_user_edit.plan_id = plan.id
      current_user_edit.save
    end

    redirect_to home_path
  end

  def cancel_plan

  end
end

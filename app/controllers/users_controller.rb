class UsersController < ApplicationController
  before_action :require_login

  def index

  end

  def avail_plan
    plan = Plan.new
    plan.name = params[:name]
    plan.price = params[:price]
    plan.duration = params[:duration]

    if(plan.name.present? && plan.price.present? && plan.duration.present?)
      plan.save
    end

    redirect_to home_path
  end

  def cancel_plan

  end
end

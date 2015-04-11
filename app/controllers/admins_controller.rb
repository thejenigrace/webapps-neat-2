class AdminsController < ApplicationController

	def admin_login
		
	end

	def admin_login_attempt
		username = params[:username]
		passcode = params[:passcode]

		admin_user = Admin.find_by(username: username, passcode: passcode)

		if admin_user.present?
			session[:admin_id] = admin_user.id
			redirect_to action: :menu_plans
		else
			redirect_to action: :admin_login
		end
	end

	def admin_logout_attempt
		session[:admin_id] = nil
      	redirect_to action: :admin_login
	end

	def menu_plans
		redirect_to admins_admin_login_path if session[:admin_id].nil?
		@plan1 = Plan.where(id: 1).first
      	@plan2 = Plan.where(id: 2).first
      	@plan3 = Plan.where(id: 3).first
      	@plan4 = Plan.where(id: 4).first
      	@plan5 = Plan.where(id: 5).first
      	@plan6 = Plan.where(id: 6).first
	end

	def edit_plan
		name = params[:new_name]
		price = params[:new_price]
		description = params[:new_description]
		id = params[:plan_id]

		editted_plan = Plan.find(id)
		editted_plan.name = name
		editted_plan.price = price
		editted_plan.description = description
		editted_plan.save

		redirect_to action: :menu_plans
	end

	def transactions
		redirect_to admins_admin_login_path if session[:admin_id].nil?
		dateToday = Date.today.strftime("%m/%d/%Y")
		@transactionslist = Transaction.where('end_date >= ?', dateToday).order(:end_date).joins(:user, :plan).to_a
	end
end

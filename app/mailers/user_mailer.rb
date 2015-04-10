class UserMailer < ApplicationMailer
  default from: 'neathealthylifestyle@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: user.email,
         subject: 'Welcome to Neat, #{user.name}!')
  end

  def avail_plan_confirmation(user, plan, transaction)
    @user = user
    @plan = plan
    @transaction = transaction
    mail(to: user.email,
         subject: 'Neat Healthy Lifestyle - Plan Availed')
  end

  def cancel_plan_confirmation(user, plan, transaction)
    @user = user
    @plan = plan
    @transaction = transaction
    mail(to: user.email,
         subject: 'Neat Healthy Lifestyle - Plan Cancelled')
  end

end

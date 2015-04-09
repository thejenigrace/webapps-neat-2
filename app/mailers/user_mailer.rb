class UserMailer < ApplicationMailer
  default from: 'neathealthylifestyle@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: user.email,
         subject: 'Welcome to Neat, #{user.name}!')
  end

  def avail_plan_confirmation(user, plan)
    @user = user
    @plan = plan
    mail(to: user.email,
         subject: 'Neat Healthy Lifestyle - Avail of Plan')
  end
end

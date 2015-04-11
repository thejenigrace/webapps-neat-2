Rails.application.routes.draw do
  root 'sessions#index'

  # sessions_controller
  post 'sessions/login'
  get  'sessions/logout'
  post 'sessions/logout'
  post 'sessions/register'

  get 'sessions/confirmation'
  post 'sessions/confirm_email'

  # users_controller
  get  'home' => 'users#index'
  post 'users/index'

  get  'users/avail_plan'
  post 'users/avail_plan'

  get  'users/cancel_plan'
  post 'users/cancel_plan'

  get 'users/edit_user_info'
  post 'users/edit_user_info'
  
  # admins_controller
  get 'admins/admin_login'
  post 'admins/admin_login_attempt'
  post 'admins/edit_plan'
  get 'admins/admin_logout_attempt'
  get 'admins/menu_plans'
  get 'admins/transactions'

end

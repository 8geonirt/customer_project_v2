Rails.application.routes.draw do
  devise_for :admins
  devise_for :employees
  root 'manage#index'
  resources :manage
  delete 'manage/:id/destroy' => 'manage#destroy'
  get 'manage/:id/arrival_report' => 'manage#arrival_report'
  get 'manage/arrival_report/:id/section' => 'manage#arrival_report_section'
  get 'manage/:id/working_time' => 'manage#working_time'
  get 'manage/:id/working_time/section' => 'manage#working_time_section'
  get 'manage/:id/not_worked_days' => 'manage#not_worked_days'
  get 'manage/:id/not_worked_days/section' => 'manage#not_worked_days_section'
  get 'manage/:id/add_entry_time' => 'manage#add_entry_time'
  post 'manage/save_entry' => 'manage#save_entry'
  get 'employee/' => 'employee#index'
  get 'employee/profile' => 'employee#profile'
  get 'home/' => 'home#index'
  get 'home/unauthorized' => 'home#unauthorized'
  namespace :api do
    resources :control
  end
end

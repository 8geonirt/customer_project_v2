Rails.application.routes.draw do
  root 'manage#index'
  resources :manage
  delete 'manage/:id/destroy' => 'manage#destroy'
  get 'manage/:id/arrival_report' => 'manage#arrival_report'
  get 'manage/arrival_report/:id/section' => 'manage#arrival_report_section'
  get 'manage/:id/working_time' => 'manage#working_time'
  get 'manage/:id/working_time/section' => 'manage#working_time_section'
  namespace :api do
    resources :control
  end
end

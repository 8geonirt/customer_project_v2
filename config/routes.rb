Rails.application.routes.draw do
  root 'manage#index'
  resources :manage
  delete 'manage/:id/destroy' => 'manage#destroy'
  get 'manage/:id/arrival_report' => 'manage#arrival_report'
  get 'manage/arrival_report/:id/section' => 'manage#arrival_report_section'
  namespace :api do
    resources :control
  end
end

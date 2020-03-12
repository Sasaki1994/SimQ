Rails.application.routes.draw do
  root to: 'questions#index'
  get 'questions' => 'questions#search'
end

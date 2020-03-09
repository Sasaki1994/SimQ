Rails.application.routes.draw do
  root to: 'questions#index'
  post 'questions' => 'questions#search'
end

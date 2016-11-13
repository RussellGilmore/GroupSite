Rails.application.routes.draw do
    devise_for :users, controllers: { registrations: 'registrations' }
    root to: 'pages#forum'

    get 'pages/forum'      => 'pages#forum'
    get 'pages/text_chat'  => 'pages#text_chat'
    get 'pages/drive'      => 'pages#drive'
    get 'pages/video_chat' => 'pages#video_chat'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

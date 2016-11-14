Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    # redirect to the sign in page if the user is not authenticated
    authenticated :user do
        root to: 'pages#forum', as: :authenticated_root
    end
    root to: redirect('/users/sign_in')

    get 'pages/forum'      => 'pages#forum'
    get 'pages/text_chat'  => 'pages#text_chat'
    get 'pages/drive'      => 'pages#drive'
    get 'pages/video_chat' => 'pages#video_chat'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

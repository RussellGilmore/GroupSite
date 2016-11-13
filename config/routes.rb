Rails.application.routes.draw do
    root to: 'posts#forum_index'

    get 'pages/forum'      => 'pages#forum'
    get 'pages/text_chat'  => 'pages#text_chat'
    get 'pages/drive'      => 'pages#drive'
    get 'pages/video_chat' => 'pages#video_chat'
    resources :posts

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

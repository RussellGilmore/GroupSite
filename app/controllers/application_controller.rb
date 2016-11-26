class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # Configure the parameters that are permitted for sign up and account updates.
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit :sign_up, keys: [:registration_key, :username, :email, :password, :password_confirmation]
        devise_parameter_sanitizer.permit :account_update, keys: [:username, :email, :current_password], except: [:password, :password_confirmation]
    end
end

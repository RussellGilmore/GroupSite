class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    private

    # Overwrite the sign_out redirect path method
    # Redirect to the sign in page
    def after_sign_out_path_for(_resource_or_scope)
        url_for controller: 'devise/sessions', action: 'new'
    end
end

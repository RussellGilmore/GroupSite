class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # Handles callbacks for Facebook sign in
    # Users are redirected to the registration page
    def facebook
        auth = request.env['omniauth.auth']
        @user = User.from_omniauth(auth)

        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
            set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
        else
            # Store the provider and uid in the session for use in registration
            session[:provider] = auth.provider
            session[:uid] = auth.uid
            render 'users/new'
        end
    end

    # Handles callbacks for Google` sign in
    # Users are redirected to the registration page
    def google_oauth2
        auth = request.env['omniauth.auth']
        @user = User.from_omniauth(auth)

        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
            set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
        else
            # Store the provider and uid in the session for use in registration
            session[:provider] = auth.provider
            session[:uid] = auth.uid
            render 'users/new'
        end
    end

    # Creates a new user for Facebook and Google registration.
    def create
        @user = User.new(user_params)
        @user.password = Devise.friendly_token[0, 20]
        @user.provider = session[:provider]
        @user.uid = session[:uid]
        @user.save
        if @user.persisted?
            session.delete :provider
            session.delete :uid
            sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
            set_flash_message(:notice, :success, kind: @user.provider == :facebook ? 'Facebook' : 'Google') if is_navigational_format?
        else
            render 'users/new'
      end
    end

    def failure
        redirect_to controller: 'devise/sessions', action: 'new'
    end

    # The permitted parameters for user registration
    def user_params
        params.require(:user).permit(:registration_key, :username, :email)
    end
end

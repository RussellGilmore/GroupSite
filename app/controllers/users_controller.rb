class UsersController < ApplicationController
    before_action :authenticate_user!

    # Edit the current user's password
    def edit
        @user = current_user
    end

    # Update the user's password
    def update
        @user = User.find(current_user.id)
        if @user.update_with_password(user_params)
            # Sign in the user and bypass validation in case their password changed
            bypass_sign_in(@user)
            flash[:notice] = 'Your password has been changed successfully.'
            redirect_to root_path
        else
            render 'edit'
        end
    end

    private

    def user_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end

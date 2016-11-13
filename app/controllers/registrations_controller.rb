class RegistrationsController < Devise::RegistrationsController
    private

  # Redirect to the sign in page after registration
  def after_inactive_sign_up_path_for(_resource)
      url_for controller: 'devise/sessions', action: 'new'
  end
end

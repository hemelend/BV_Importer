class PasswordsController < Devise::PasswordsController

  # POST /resource/password
  def create
    user = resource_class.find_by(resource_params)
    user.send_reset_password_instructions if user
    yield user if block_given?
    if user && successfully_sent?(user)
      notice = 'You will receive an email with instructions on how to reset your password in a few minutes.'
    else
      notice = 'Please enter valid email address.'
    end
    redirect_to root_path, notice: notice
  end
end
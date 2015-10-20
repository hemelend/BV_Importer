class SessionsController < Devise::SessionsController
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    # super
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.html {render layout: false}
    end
  end

  # POST /resource/sign_in
  def create
    if user_signed_in?
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      redirect_to imported_files_path
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: 'Email Address or Password are incorrect please try again!.' }
        format.js
        format.json { head :no_content }
      end
    end
  end
end
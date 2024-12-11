class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  # adding first,last, and username to devise parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :username ])
  end
end

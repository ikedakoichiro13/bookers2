class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :set_flash_message_to_headers

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:success] = "Signed out successfully."
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def set_flash_message_to_headers
    return unless request.xhr?
    response.headers['X-Flash-Messages'] = flash_json
    flash.discard
  end

  private

  def flash_json
    flash.to_hash.slice('success', 'error', 'alert', 'notice').map do |type, message|
      %(<div data-alert class="alert-box #{type}">#{message}</div>)
    end.join("\n")
  end
end

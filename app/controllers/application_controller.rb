class ApplicationController < ActionController::Base
  before_action :configure_permitted_paramerters, if: :devise_controller?

  private

  def configure_permitted_paramerters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:nickname, :family_name, :first_name,
                       :family_name_k, :first_name_k, :birth_day]
    )
  end
end

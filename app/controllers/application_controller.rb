class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end
  def production?
    Rails.env.production?
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password])
  end

  def profile_params
    params.require(:profile).permit(:first_name,:family_name,:first_name_kana,:family_name_kana,:birthday)
  end

  def sending_destination_params
    params.require(:address).permit(:destination_first_name,:destination_family_name,:post_code,:destination_first_name_kana,:destination_family_name_kana,:prefecture_code, :city, :house_number, :building_name, :phone_number)
  end
end
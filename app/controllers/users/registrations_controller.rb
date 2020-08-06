# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @profile = @user.build_profile
    # @sending_destination = @user.build_sending_destination
    render :new_profile
  end

  def create_profiles
    params[:profile][:birthday] = birthday_join
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new_profiles and return
    end
    session["devise.regist_data2"] = {profile: @profile.attributes}
    # @user.build_profile(@profile.attributes)
    # @user.save
    # session["devise.regist_data"]["user"].clear
    @sending_destination = @user.build_sending_destination
    render :new_sending_destination
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["devise.regist_data2"]["profile"])
    @sending_destination = SendingDestination.new(sending_destination_params)
    unless @sending_destination.valid?
      flash.now[:alert] = @sending_destination.errors.full_messages
      render :new_sending_destination and return
    end
    @user.build_sending_destination(@sending_destination.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path
  end

  def update
    if current_user.update(sign_up_params)
      sign_in(current_user, :bypass => true)
      redirect_to edit_done_users_path
    else
      render :edit
    end
  end

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

 
 private 
 
   def birthday_join
     # パラメータ取得
     date = params[:birthday]
     # ブランク時のエラー回避のため、ブランクだったら何もしない
     if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
       return
     end
 
     # 年月日別々できたものを結合して新しいDate型変数を作って返す
     Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
 
   end
end

class SessionsController < ApplicationController
  before_action :get_user, only: [:reset_password_link, :update_user_password, :reset_password, :create]
  before_action :email_verified?, only: [:reset_password_link]
  before_action :reset_link_expired?, only: [:update_user_password]
  before_action :password_empty?, only: [:update_user_password]

  def create
    if @user.authenticate(params[:password])
      if @user.email_confirmed
        create_user(@user)
      else
        redirect_with_flash("danger", "activate_your_account", new_user_url)
      end
    else
      redirect_with_flash("danger", "invalid_password", login_url)
    end
  end

  def reset_password_link
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_with_flash("info", "password_reset_mail", login_url)
    end
  end

  def update_user_password
    if @user.update_attributes(user_params)
      @user.update_attribute(:reset_digest, nil)
      redirect_with_flash("success", "new_password_saved", login_url)
    else
      render 'reset_password'
    end
  end


  def destroy
    logout_user if @current_user
    redirect_to login_url
  end

  private
    def password_empty?
      if params[:user][:password].empty?
        @user.errors.add(:password, "can't be empty")
        render 'reset_password'
      end
    end

    def get_user
      @user = User.find_by(email: params[:email])
      redirect_with_flash("danger", "email_not_found", login_url) unless @user
    end

    def email_verified?
      redirect_with_flash("danger", "email_not_verified", login_url) unless (@user.email_confirmed)
    end

    def reset_link_expired?
      redirect_with_flash("danger", "reset_link_expired",reset_password_url) if @user.password_reset_expired?
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def create_user(user)
      session[:user_id] = user.id
      params[:remember_me] == 'on' ? remember_user(user) : forget_user(user)
      redirect_to new_user_path
    end
end

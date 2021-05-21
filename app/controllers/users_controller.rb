class UsersController < ApplicationController
@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, :email, :password,
      :family_name, :first_name, :family_name_k, :first_name_k, :birth_day
    )
  end
end
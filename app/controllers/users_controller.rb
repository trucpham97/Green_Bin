class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :new, status: 422
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def score
    @users = User.all.sort_by(&:total_emission).reverse
  end

  private

  def user_params
    params.require(:user).permit(:username, :emissions, :location, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # layout 'just_no_navbar', only: [:score]
  # layout 'no_navbar', only: [:intro]


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

  def intro
  end

  private

  def user_params
    params.require(:user).permit(:username, :emissions, :location, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def resolve_layout
    case action_name
    when "score"
      "just_no_navbar"
    when "intro"
      "no_navbar"
    else
      "application" # default layout
    end
  end
end

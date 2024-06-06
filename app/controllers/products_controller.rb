class ProductsController < ApplicationController
  # before_action :set_user, only: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  layout 'no_navbar', only: [:new, :create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.save!
  end

  def show
  end

  private

  # def set_user
  #   @user = User.find(params[:user_id])
  # end

  def product_params
    params.require(:product).permit(:name, :image_url, :score, :description, :material)
  end
end

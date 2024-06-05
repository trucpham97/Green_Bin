class ProductsController < ApplicationController
  before_action :set_product, only: [:new, :create]
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
    if @product.save
      redirect_to user_products_path, notice: "Product created successfully."
    else
      render :new
    end
  end

  def show
  end

  private

  def set_product
    @product = Product.find(params[:user_id])
  end

  def product_params
    params.require(:product).permit(:name, :image_url, :score, :description, :material)
  end
end

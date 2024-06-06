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


  MATERIAL = {
    "en:plastic" => "plastic",
    "en:pet-1-polyethylen-terephthalate" => "plastic",
    "en:glass" => "glass",
    "en:green-glass" => "glass",
    "en:clear-glass" => "glass",
    "en:bottle" => "glass",
    "en:cardboard" => "paper",
    "en:paperboard" => "paper",
    "en:aluminum" => "aluminum",
    "en:canned" => "aluminum",
    "en:metal" => "metal",
    "en:steel" => "metal"
  }

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if MATERIAL.has_key?(@product.material)
      @product.tag_list.add(MATERIAL[@product.material])
    else
      @product.tag_list.add("unknown material")
    end
    @product.save!
    respond_to do |format|
      format.html { redirect_to product_path(@product) }
      format.json { render json: { id: @product.id } }
    end
  end

  def show
  end

  private
  # no need to set user thanks to devise gem - use current_user instead
  # def set_user
  #   @user = User.find(params[:user_id])
  # end

  def product_params
    params.require(:product).permit(:name, :image_url, :score, :description, :material)
  end
end

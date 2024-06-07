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

  # def filter
  #   @product = Product.find(params[:id])
  #   @recycling_spots = RecyclingSpot.tagged_with(@product.tag_list, any: true)
  #   @markers = @recycling_spots.map do |recycling_spot|
  #     {
  #       lat: recycling_spot.latitude,
  #       lng: recycling_spot.longitude,
  #       info_window_html: render_to_string(partial: "shared/info_window", locals: {recycling_spot: recycling_spot}),
  #     }
  #   end
  # end

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

  helper_method :display_material

  def display_material(product)
    case product.material
    when 'en:pet-1-polyethylen-terephthalate' || 'en:plastic' || 'en:pet-1-polyethylene-terephthalate'
      { name: 'Plastique', color: 'yellow' }
    when 'en:glass' || 'en:green-glass' || 'en:clear-glass' || 'en:bottle'
      { name: 'Verre', color: 'green' }
    when "en:cardboard" || "en:paperboard"
      { name: 'Carton', color: 'yellow' }
    when "en:aluminum" || "en:canned"
      { name: 'Aluminium', color: 'grey' }
    when "en:metal" || "en:steel"
      { name: 'Métal', color: 'grey' }
    else
      { name: 'Materiaux non disponibles', color: 'black' }
    end
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

class ProductsController < ApplicationController
  # before_action :set_user, only: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  layout :resolve_layout
  # layout 'no_navbar', only: [:new, :create]
  # layout 'just_no_navbar', only: [:index, :show]

  def index
    @products = Product.all.sort.reverse
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
    @product = Product.find(params[:id])
  end

  helper_method :display_material

  def display_material(product)
    if product.material == 'en:plastic' || product.material ==  "en:pet-1-polyethylen-terephthalate"
      { name: 'Plastique', color: 'yellow', text: 'black'}
    elsif product.material == 'en:glass' || product.material == "en:green-glass" || product.material == "en:clear-glass" || product.material == "en:bottle"
      { name: 'Verre', color: 'green' }
    elsif product.material == "en:cardboard" || product.material == "en:paperboard"
      { name: 'Carton', color: 'blue' }
    elsif product.material == "en:aluminum"  || product.material == "en:canned"
      { name: 'Aluminium', color: 'grey' }
    elsif product.material == "en:metal" || product.material == "en:steel"
      { name: 'Métal', color: 'grey' }
    else
      { name: 'Materiaux non disponibles', color: 'black' }
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Produit supprimé avec succès"
    else
      flash[:alert] = "Erreur lors de la suppression du produit"
    end
    redirect_to products_path
  end

  #méthode pour calculer le score, à implémenter la deuxième semaine
  # def score
  #   @score = current_user.emission
  #   # current_user.products.each do |product|
  #   #   current_user.emission += product.emission
  #   # end
  #   @amount = Product.all.count
  #   @score = @amount * 15
  # end

  private
  # no need to set user thanks to devise gem - use current_user instead
  # def set_user
  #   @user = User.find(params[:user_id])
  # end

  def product_params
    params.require(:product).permit(:name, :image_url, :score, :description, :material)
  end

  def resolve_layout
    case action_name
    when "new", "create"
      "no_navbar"
    when "index", "show"
      "just_no_navbar"
    else
      "application" # default layout
    end
  end
end

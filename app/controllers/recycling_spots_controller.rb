class RecyclingSpotsController < ApplicationController
  before_action :set_product, only: [:index]
  def index
    @recycling_spots = RecyclingSpot.tagged_with(@product.tag_list, any: true)
    set_markers
  end

  def list
    @recycling_spots = RecyclingSpot.all
    set_markers
  end

  def show
    @recycling_spot = RecyclingSpot.find(params[:id])
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_markers
    @markers = @recycling_spots.map do |recycling_spot|
      {
        lat: recycling_spot.latitude,
        lng: recycling_spot.longitude,
        info_window_html: render_to_string(partial: "shared/info_window", locals: {recycling_spot: recycling_spot}),
      }
    end
  end
end

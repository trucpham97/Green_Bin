class RecyclingSpotsController < ApplicationController
  # before_action :set_product, only: [:index]
  layout 'just_no_navbar', only: [:index, :list]
  def index
    @product = Product.find(params[:product_id])
    @recycling_spots = find_recycling_spots_by_tags(@product.tag_list)
    set_markers
  end

  def list
    # @recycling_spots = RecyclingSpot.near([current_user.latitude, current_user.longitude], 2)
    # @recycling_spots.concat(RecyclingSpot.near("Place Jean Macé, Lyon", 2))
    # @recycling_spots = find_nearby_recycling_spots("20 rue des Capucins, Lyon", 1.1)
    location = "20 rue des Capucins, Lyon"
    @recycling_spots = Rails.cache.fetch("nearby_recycling_spots/#{location.parameterize}", expires_in: 24.hours) do
      find_nearby_recycling_spots(location, 1)
    end
    set_markers
  end

  def show
    @recycling_spot = RecyclingSpot.find(params[:id])
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def find_recycling_spots_by_tags(tags)
    @find_recycling_spots_by_tags ||= RecyclingSpot.tagged_with(tags, any: true)
  end

  def find_nearby_recycling_spots(location, distance)
    @find_nearby_recycling_spots ||= RecyclingSpot.near(location, distance)
  end

  def set_markers
    return unless @recycling_spots.present?
    @markers = @recycling_spots.map do |recycling_spot|
      {
        lat: recycling_spot.latitude,
        lng: recycling_spot.longitude,
        info_window_html: render_to_string(partial: "shared/info_window", locals: {recycling_spot: recycling_spot}, cache: true),
        marker_html: render_to_string(partial: "shared/marker", locals: {recycling_spot: recycling_spot}, cache: true)
      }
    end
  end
end

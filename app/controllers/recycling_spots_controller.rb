class RecyclingSpotsController < ApplicationController
  # before_action :set_product, only: [:index]
  layout 'just_no_navbar', only: [:index, :list]

  caches_action :index, :list, expires_in: 24.hours
  def index
    @product = Product.find(params[:product_id])
    @all_recycling_spots = find_nearby_recycling_spots("20 rue des Capucins, Lyon", 1.3)
    @recycling_spots = @all_recycling_spots.tagged_with(@product.tag_list, any: true)
    set_markers
  end

  def list
    # @recycling_spots = RecyclingSpot.near([current_user.latitude, current_user.longitude], 2)
    # @recycling_spots.concat(RecyclingSpot.near("Place Jean Macé, Lyon", 2))
    # @recycling_spots = find_nearby_recycling_spots("20 rue des Capucins, Lyon", 1.1)
    location = "20 rue des Capucins, Lyon"
    @recycling_spots = find_nearby_recycling_spots(location, 1)
    set_markers
  end

  def show
    @recycling_spot = RecyclingSpot.find(params[:id])
  end

  private

  # def set_product
  #   @product = Product.find(params[:product_id])
  # end

  # def find_recycling_spots_by_tags(tags)
  #   RecyclingSpot.tagged_with(tags, any: true)
  # end

  def find_nearby_recycling_spots(location, distance)
    RecyclingSpot.near(location, distance)
  end

  def set_markers
    return unless @recycling_spots.present?
    @markers = @recycling_spots.map do |recycling_spot|
      {
        lat: recycling_spot.latitude,
        lng: recycling_spot.longitude,
        info_window_html: render_to_string(partial: "shared/info_window", locals: {recycling_spot: recycling_spot}),
        marker_html: render_to_string(partial: "shared/marker", locals: {recycling_spot: recycling_spot})
      }
    end
  end
end

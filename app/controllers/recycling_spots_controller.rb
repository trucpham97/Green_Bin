class RecyclingSpotsController < ApplicationController
  def index
    @recycling_spots = RecyclingSpot.all
    @markers = @recycling_spots.map do |recycling_spot|
      {
        lat: recycling_spot.latitude,
        lng: recycling_spot.longitude
      }
    end
  end

  def show
    @recycling_spot = RecyclingSpot.find(params[:id])
  end
end

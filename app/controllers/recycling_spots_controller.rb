class RecyclingSpotsController < ApplicationController
  def index
    @recycling_spots = RecyclingSpot.all
  end

  def show
    @recycling_spot = RecyclingSpot.find(params[:id])
  end
end

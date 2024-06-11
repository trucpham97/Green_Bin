class RecyclingSpotInfosController < ApplicationController

  def index
    @spots = RecyclingPointInfo.all
    if params[:query].present?
      @spots = @spots.select do | spot |
        spot.search_terms_hidden.any? do | term |
          term.downcase.include?(params[:query].downcase)
        end || spot.title.downcase.include?(params[:query].downcase)
      end
    end
  end

end

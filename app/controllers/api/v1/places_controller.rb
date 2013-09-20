class Api::V1::PlacesController < ApplicationController
  
  def show
    @place = Place.find(params[:id])
    respond_to do |f|
      f.json { render json: PlacePresenter.new(@place) }
    end
  end
  
end

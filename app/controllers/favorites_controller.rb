class FavoritesController < ApplicationController
  before_action :set_facility

  def create
    @favorite = current_user.favorites.create(facility_id: params[:facility_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = current_user.favorites.find_by(facility_id: @facility.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end
end

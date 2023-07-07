class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[ show edit update destroy ]

  def index
    @facilities = Facility.all
  end

  def show
    @facilities = facility.find(params[id])
  end

  def new
    @facility = Facility.new
  end

  def edit
  end

  def create
    @facility = Facility.new(facility_params)
  end

  def update
  end

  def destroy
    @facility.destroy
  end

  private
    def set_facility
      @facility = Facility.find(params[:id])
    end

    def facility_params
      params.require(:facility).permit(:name, :address, :station, :tel, :homepage)
    end
end

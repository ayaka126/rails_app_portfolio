class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[ show edit update destroy ]

  def index
    @facilities = Facility.all
  end

  def show
  end

  def new
    @facility = Facility.new
  end

  def edit
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      redirect_to facility_path(@facility), notice: "新規登録が完了しました"
    else
      render :new,  status: :unprocessable_entity
    end
  end

  def update
    if @facility.update(facility_params)
      redirect_to facility_path, notice: "情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @facility.destroy
    redirect_to facilities_path
  end

  private
    def set_facility
      @facility = Facility.find(params[:id])
    end

    def facility_params
      params.require(:facility).permit(:name, :address, :station, :tel, :homepage)
    end
end

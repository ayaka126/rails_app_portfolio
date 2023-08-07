class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[ show edit update destroy ]

  def index
    @facilities = Facility.all
  end

  def indexbymap
    @facilities = Facility.all
    @nearby_facilities = nearby_facilities
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
      render new_facility_path, status: :unprocessable_entity
    end
  end

  def update
    if @facility.update(facility_params)
      redirect_to facility_path, notice: "情報を更新しました"
    else
      redirect_to :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @facility.destroy
    redirect_to facilities_path
  end

  def search
    @facilities = Facility.search(params[:keyword])
  end

  def search_by_area
    @area_name = params[:area_name]
    @facilities = Facility.search_by_area(@area_name)
    render 'search'
  end

  private
    def set_facility
      @facility = Facility.find(params[:id])
    end

    def facility_params
      params.require(:facility).permit(:name, :address, :station, :tel, :homepage, :opening_hours)
    end

    def nearby_facilities
      current_location = [latitude, longitude]
      if current_location.compact.blank?
        # 現在地情報がない場合のデフォルト位置は赤羽駅
        default_location = [35.777615, 139.7209868]
        Facility.near(default_location, 2, units: :km)
      else
        Facility.near(current_location, 2, units: :km)
      end
    end

    def latitude
      params[:latitude].to_f
    end
  
    def longitude
      params[:longitude].to_f
    end
end

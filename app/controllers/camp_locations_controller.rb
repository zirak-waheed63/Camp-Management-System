class CampLocationsController < Admin::BaseController
  before_action :set_camp_location, only: %i[ show edit update destroy ]

  def index
    @camp_locations = CampLocation.all
  end

  def show
  end

  def new
    @camp_location = CampLocation.new
  end

  def edit
  end

  def create
    @camp_location = CampLocation.new(camp_location_params)

    respond_to do |format|
      if @camp_location.save
        format.html { redirect_to @camp_location, notice: "Camp location was successfully created." }
        format.json { render :show, status: :created, location: @camp_location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @camp_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @camp_location.update(camp_location_params)
        format.html { redirect_to @camp_location, notice: "Camp location was successfully updated." }
        format.json { render :show, status: :ok, location: @camp_location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @camp_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @camp_location.destroy
    respond_to do |format|
      format.html { redirect_to camp_locations_url, notice: "Camp location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_camp_location
      @camp_location = CampLocation.find(params[:id])
    end

    def camp_location_params
      params.require(:camp_location).permit(:name)
    end
end

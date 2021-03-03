class CampLocationsController < ApplicationController
  before_action :set_camp_location, only: %i[ show edit update destroy ]
  before_action :is_admin?
  # GET /camp_locations or /camp_locations.json
  def index
    @camp_locations = CampLocation.all
  end

  # GET /camp_locations/1 or /camp_locations/1.json
  def show
  end

  # GET /camp_locations/new
  def new
    @camp_location = CampLocation.new
  end

  # GET /camp_locations/1/edit
  def edit
  end

  # POST /camp_locations or /camp_locations.json
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

  # PATCH/PUT /camp_locations/1 or /camp_locations/1.json
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

  # DELETE /camp_locations/1 or /camp_locations/1.json
  def destroy
    @camp_location.destroy
    respond_to do |format|
      format.html { redirect_to camp_locations_url, notice: "Camp location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp_location
      @camp_location = CampLocation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camp_location_params
      params.require(:camp_location).permit(:name)
    end
end

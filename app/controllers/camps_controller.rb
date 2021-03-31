class CampsController < Admin::BaseController
  before_action :set_camp, only: %i[show edit update destroy toggle_status]

  def index
    @camps = Camp.all
  end

  def show; end

  def new
    @camp = Camp.new
  end

  def edit; end

  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: "Camp was successfully created." }
        format.json { render :show, status: :created, location: @camp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to @camp, notice: "Camp was successfully updated." }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to camps_url, notice: "Camp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_status
    @camp.toggle!(:status)
    redirect_to camps_path
  end

  private
  
  def set_camp
    @camp = Camp.find(params[:id])
  end

  def camp_params
    params.require(:camp).permit(:name, :start_date, :end_date, :status, camp_location_ids: [])
  end
end

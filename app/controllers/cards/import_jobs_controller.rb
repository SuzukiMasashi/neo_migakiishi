class Cards::ImportJobsController < ApplicationController
  before_action :set_cards_import_job, only: [:show, :edit, :update, :destroy]

  # GET /cards/import_jobs
  # GET /cards/import_jobs.json
  def index
    @cards_import_jobs = Cards::ImportJob.includes(:version)
  end

  # GET /cards/import_jobs/1
  # GET /cards/import_jobs/1.json
  # def show
  # end

  # GET /cards/import_jobs/new
  def new
    version_extraction_service = VersionExtractionService.create

    version_extraction_service.create_versions!

    if selected_version = Version.find_by(name: version_extraction_service.latest_version_name)
      @cards_import_job = Cards::ImportJob.new(version: selected_version)
    else
      raise RuntimeError
    end
  end

  # GET /cards/import_jobs/1/edit
  # def edit
  # end

  # POST /cards/import_jobs
  # POST /cards/import_jobs.json
  def create
    @cards_import_job = Cards::ImportJob.new(cards_import_job_params)

    cards_extraction_service = CardsExtractionService.create(@cards_import_job)

    cards_extraction_service.create_cards!

    respond_to do |format|
      if @cards_import_job.save
        format.html { redirect_to version_cards_url(@cards_import_job.version), notice: 'Import job was successfully created.' }
        format.json { render :show, status: :created, location: @cards_import_job }
      else
        format.html { render :new }
        format.json { render json: @cards_import_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/import_jobs/1
  # PATCH/PUT /cards/import_jobs/1.json
  # def update
  #   respond_to do |format|
  #     if @cards_import_job.update(cards_import_job_params)
  #       format.html { redirect_to @cards_import_job, notice: 'Import job was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @cards_import_job }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @cards_import_job.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /cards/import_jobs/1
  # DELETE /cards/import_jobs/1.json
  def destroy
    @cards_import_job.destroy
    respond_to do |format|
      format.html { redirect_to cards_import_jobs_url, notice: 'Import job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cards_import_job
      @cards_import_job = Cards::ImportJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cards_import_job_params
      params.require(:cards_import_job).permit(:version_id, :status)
    end
end

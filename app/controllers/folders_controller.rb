class FoldersController < ApplicationController
  before_action :set_folder, only: %i[ show edit update destroy]
  before_action :authorize_user

  # GET /folder or /folder.json
  def index
    @folders = Folder.all
  end

  # GET /folder/1 or /folder/1.json
  def show
  end

  # GET /folder/new
  def new
    @folder = Folder.new
  end

  # GET /folder/1/edit
  def edit
  end

  # POST /folder or /folder.json
  def create
    @folder = Folder.new(folder_params.merge(user: current_user))

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folder_url(@folder), notice: "Folder was successfully created." }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folder/1 or /folder/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to folder_url(@folder), notice: "Folder was successfully updated." }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folder/1 or /folder/1.json
  def destroy
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to folders_url, notice: "Folder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.includes(:documents).find(params[:id])
    end

    def authorize_user
      authorize(@folder || Folder)
    end

    # Only allow a list of trusted parameters through.
    def folder_params
      params.require(:folder).permit(:name)
    end
end

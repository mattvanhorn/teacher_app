class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy]
  before_action :authorize_user

  # GET /documents or /documents.json
  def index
    @folders = current_user.folders
    @my_documents = @folders.map(&:documents).flatten
    @documents = Document.where(folder: nil)
  end

  # GET /documents/1 or /documents/1.json
  def show
    respond_to do |format|
      format.html
      format.preview { render body: @document.to_markdown.html_safe }
    end
  end

  # GET /documents/new or /folder/:folder_id/documents/new
  def new
    @folder = current_user.folders.find_by(id: params[:folder_id])
    @document = Document.new(folder: @folder)
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /folder/:folder_id/documents
  def create
    # prevent URL twiddling to create documents in other users' folders
    folder = current_user.folders.find_by(id: params[:folder_id])
    @document = Document.new(document_params.merge(folder: folder))

    respond_to do |format|
      if @document.save
        format.html { redirect_to document_url(@document), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to document_url(@document), notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    def authorize_user
      authorize(@document || Document)
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:title, :file)
    end
end

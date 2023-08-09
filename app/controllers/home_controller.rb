class HomeController < ApplicationController
  def index
    if current_user && current_user.student?
      @folders = Folder.all
      @public_documents = Document.where(folder: nil)
    end
    render
  end
end

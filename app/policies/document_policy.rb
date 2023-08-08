class DocumentPolicy < ApplicationPolicy
  attr_reader :user, :document

  def initialize(user, document)
    @user = user
    @document = document
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.teacher?
  end

  def new?
    create?
  end

  def update?
    @user.teacher? && owns_document?
  end

  def edit?
    update?
  end

  def destroy?
    @user.teacher? && owns_document?
  end

  private

  def owns_document?
    @document.folder ? (@document.folder.user == @user) : true
  end

end
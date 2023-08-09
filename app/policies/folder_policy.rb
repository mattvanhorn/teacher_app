class FolderPolicy < ApplicationPolicy
  attr_reader :user, :folder

  def initialize(user, folder)
    @user = user
    @folder = folder
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
    @user.teacher? && owns_folder?
  end

  def edit?
    update?
  end

  def destroy?
    @user.teacher? && owns_folder?
  end

  private

  def owns_folder?
    @folder.user == @user
  end
end
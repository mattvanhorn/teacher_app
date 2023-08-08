class UserPolicy < ApplicationPolicy
  attr_reader :user, :document

  def initialize(user, target_user)
    @user = user
    @target_user = target_user
  end

  def index?
    @user.admin?
  end

  def show?
    true
  end

  def create?
    @user.admin?
  end

  def new?
    create?
  end

  def update?
    @user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin?
  end

end
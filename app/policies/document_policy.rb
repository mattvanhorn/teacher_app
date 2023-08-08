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
    @user.teacher?
  end

  def edit?
    update?
  end

  def destroy?
    @user.teacher?
  end

end
class QuestionPolicy < ApplicationPolicy
  delegate :good?, :shit?, :revoke?, to: :vote_policy

  def index?
    true
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    user.confirmed?
  end

  def new?
    create?
  end

  def update?
    owner?
  end

  def edit?
    update?
  end

  def destroy?
    owner?
  end

  private

  def vote_policy
    Pundit.policy!( @user, @record.vote_for( user ))
  end
end

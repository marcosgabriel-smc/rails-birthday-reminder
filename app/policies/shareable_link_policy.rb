class ShareableLinkPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end
end

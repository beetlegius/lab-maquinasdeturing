class Ability
  include CanCan::Ability

  def initialize(usuario)
    can :manage, :all
  end
end

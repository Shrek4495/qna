class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities
    can :me, User, { user_id: user.id }
    can :create, [Question, Answer]
    can %i[update destroy], [Question, Answer], author_id: user.id
    can :destroy, Link, linkable: { author_id: user.id }

    can :destroy, ActiveStorage::Attachment do |file|
      user.id.eql?(file.record.author_id)
    end
  end
end
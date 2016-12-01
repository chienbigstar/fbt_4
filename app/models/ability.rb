class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    user ||= User.new
    case controller_namespace
    when "Admin"
      can :manage, :all if user.admin?
    else
      if user.user?

        can :read, :all

        can [:new, :create], Review
        can [:edit, :update, :destroy], Review do |review|
          review.user == user
        end

        can :create, Like
        can :destroy, Like do |like|
          like.user == user
        end

        can [:new, :create], Booking
        can [:destroy], Booking do |booking|
          booking.user == user && booking.waiting_pay?
        end

        can :manage, :payment

        can [:new, :create], Comment
        can [:edit, :update, :destroy], Comment do |comment|
          comment.user == user
        end
      else
        can :read, Tour
        can :read, Review
      end
    end
  end
end

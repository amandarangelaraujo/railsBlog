# frozen_string_literal: true

class Ability
  include CanCan::Ability
  #3 - admin
  #2 - autor
  #1 - usuário
  
  def initialize(user)
    user ||= User.new
    if user.user_type==3
      can :manage, :all # Administrador pode gerenciar tudo
    elsif user.user_type==2
      can :create, Article
      can :create, Comment
      can :manage, Article, user_id: user.id 
      can :manage, Comment, user_id: user.id
      can :read, Article # Autor pode gerenciar seus próprios artigos
    else
      can :read, Article # Visitantes podem apenas ler os artigos
    end




    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end

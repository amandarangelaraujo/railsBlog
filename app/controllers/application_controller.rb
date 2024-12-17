class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  # class ApplicationController < ActionController::Base
  #   rescue_from CanCan::AccessDenied do |exception|
  #     redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
  #   end
  # end
  
end

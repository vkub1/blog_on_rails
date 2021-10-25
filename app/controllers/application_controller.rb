class ApplicationController < ActionController::Base
    add_flash_types :info, :success

    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user

    private
    def authenticated_user!
        redirect_to new_session_path, alert: "Please sign in" unless current_user.present?
    end

    
end

class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :change_password, :update_password]
    before_action :authenticated_user!, only: [:edit, :change_password]
    before_action :authorize_user!, only: [:edit, :change_password, :update, :update_password]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Signed Up successfully!"
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        
    end

    def update
        if current_user.update(user_params)
            flash[:success] = "Profile editted!"
            redirect_to root_path
        else
            render :edit
        end
    end

    def change_password
        
    end

    def update_password
        if (current_user.authenticate(params[:current_password]))
            if (params[:current_password] != params[:new_password])
                if @user.update(
                    password: params[:new_password],
                    password_confirmation: params[:new_password_confirm]
                )
                flash[:success] = "Password updated!"
                redirect_to root_path
                else
                    render :change_password
                end
            else 
                @user.errors.add(:password, "current and new can't be the same")
                render :change_password
            end
        else
            flash[:alert] = "Incorrect current password"
            render :change_password
        end
    end


    private 

    def find_user 
        @user = User.find params[:id]
    end
    
    def user_params
        params.require(:user).permit(
            :name,
            :email,
            :password,
            :password_confirmation
        )
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless can?(:crud, @user)
    end
end

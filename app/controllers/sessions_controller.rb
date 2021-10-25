class SessionsController < ApplicationController
    def new
        
    end

    def create 
        @user = User.find_by_email params[:email]
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:success] = "Logged in successfully"
            redirect_to root_path
        else
            flash[:alert] = "wrong email or password"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:alert] = "Logged out"
        redirect_to root_path
    end
end

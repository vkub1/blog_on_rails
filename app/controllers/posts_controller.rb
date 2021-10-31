class PostsController < ApplicationController
    before_action :get_post, only:[:show, :destroy, :edit, :update]
    before_action :authenticated_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:update, :destroy]
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            flash[:success] = "Post successfully created"
            redirect_to post_path(@post.id)
        else 
            render :new
        end
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def show
        @comment = Comment.new
        @comments = @post.comments.order(created_at: :desc)
    end

    def destroy
        @post.destroy
        flash[:info] = "Post deleted!"
        redirect_to posts_path
    end

    def edit

    end

    def update
        if @post.update(post_params)
            flash[:success] = "Post updated!"
            redirect_to post_path(@post.id)
        else
            render :edit
        end
    end

    private

    def get_post
        @post = Post.find params[:id] 
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless can?(:crud, @post)
    end
end

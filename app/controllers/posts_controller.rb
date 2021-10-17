class PostsController < ApplicationController
    before_action :get_post, only:[:show, :destroy, :edit]
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "Post successfully created"
            redirect_to post_path(@post.id)
        else 
            render :new
        end
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def show

    end

    def destroy
        @post.destroy
        flash[:info] = "Post deleted!"
        redirect_to posts_path
    end

    def edit

    end

    private

    def get_post
        @post = Post.find params[:id] 
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end
end

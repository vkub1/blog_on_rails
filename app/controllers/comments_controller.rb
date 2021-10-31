class CommentsController < ApplicationController
    before_action :find_post
    before_action :find_comment
    before_action :authenticated_user!
    before_action :authorize_user!

    def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            flash[:success] = "Comment created!"
            redirect_to post_path(@post.id)
        else
            @comments = @post.comments.order(created_at: :desc)
            render '/posts/show'
        end
    end

    def destroy
        if comment.destroy
            flash[:success] = "Comment deleted!"
        else
            flash[:danger] = comment.errors.full_messages
        end
        redirect_to post_path(comment.post)
    end

    private

    def find_post
        @post = Post.find params[:post_id]
    end

    def find_comment
        @comment = Comment.find params[:id]
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless can?(:crud, @comment)
    end
end

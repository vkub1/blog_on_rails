class CommentsController < ApplicationController
    before_action :find_post
    def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.save
        flash[:success] = "Comment created!"
        redirect_to post_path(@post.id)
    end

    private

    def find_post
        @post = Post.find params[:post_id]
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end

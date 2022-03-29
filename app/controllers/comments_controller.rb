class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = @post.comments.new(
      text: comment_params,
      author_id: @post.id,
      post_id: @post.id
    )
    @new_comment.post_id = @post.id
    @new_comment.update_comments_counter
    respond_to do |format|
      format.html do
        if @new_comment.save
          redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", notice: 'Success!'
          # redirect_to user_post_path(@post.id, Post.find(params[:post_id]))
        else
          render :new, alert: 'Failed to Create!'
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end

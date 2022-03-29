class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    # new object from params
    @user = User.find(params[:user_id])
    @new_post = @user.posts.new(post_parms)
    @new_post.likes_counter = 0
    @new_post.comment_counter = 0
    respond_to do |format|
      format.html do
        if @new_post.save
          flash.alert = 'Successful created'
          redirect_to "/users/#{@new_post.author.id}/posts/", notice: 'Created Successfully'

        else
          render :new, alert: 'Failed to create'
        end
      end
    end
  end

  private

  def post_parms
    params.require(:post).permit(:title, :text)
  end
end

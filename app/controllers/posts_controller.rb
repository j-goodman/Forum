class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    redirect_to topics_url
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to topic_url(@post.topic)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to topic_url(@post.topic)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to topic_url(@post.topic)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to topic_url(@post.topic)
  end

  private
  def post_params
    params.require(:post).permit(:body, :topic_id)
  end
end

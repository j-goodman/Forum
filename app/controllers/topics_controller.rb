class TopicsController < ApplicationController
  before_action :require_signed_in!

  def show
    @topic = Topic.find(params[:id])
    render :show
  end

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topic_url(@topic)
    else
      flash.now[:errors] = @topic.errors.full_messages
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to topic_url(@topic)
    else
      flash.now[:errors] = @topic.errors.full_messages
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end

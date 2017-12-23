class V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    posts = Post.all
    
    puts "Post Controller - params: #{params}"
    if params["journy_id"]
      posts = Post.where(journy_id: params["journy_id"])
    elsif params["user_id"]
      posts = Post.where(user_id: params["user_id"])
    end
    
    render json: posts, status: :ok
  end

  def show
    post = Post.find_by(id: params[:id]) || nil
    
    render json: post, status: :ok
  end
  
  def create
    puts "Post params #{post_params}"
    new_post = Post.create(post_params)
    
    if new_post.errors.count == 0
      render json: new_post, status: :ok
    else
      render json: new_post.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find_by(id: params[:id])
    
    unless post.nil?
      if post.update(post_params)
        render json: post, status: :ok and return
      else
        render json: post.errors, status: 500 and return
      end
    end
    
    render json: {status: false}, status: :unprocessable_entity
    
  end

  def destroy
    post = Post.find_by(id: params[:id])
    
    if post
      if post.destroy
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
      end
    else
      render json: {status: false}, status: :unprocessable_entity
    end
    
  end
  
  private 
  
  def post_params
    params.required(:post).permit(:title, :content, :video_url, :image_urls, :journey_id)
      .tap do |permitted|
        if(permitted[:journey_id])
          permitted[:journy_id] = permitted[:journey_id]
          permitted.delete(:journey_id)
        end
      end
  end
end

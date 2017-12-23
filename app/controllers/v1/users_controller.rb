class V1::UsersController < ApplicationController
  def index  
    users = (filter_params.empty?) ?
      User.all :
      User.where(filter_params)
    
    render json: users, status: :ok
  end

  def show
    user = User.find_by(user_id: params[:id]) || nil
    
    render json: user, status: :ok
  end
  
  def create
    puts "User params #{user_params}"
    new_user = User.create(user_params)
    
    if new_user.errors.count == 0
      render json: new_user, status: :ok
    else
      render json: new_user.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(id: params[:id])
    
    unless user.nil?
      if user.update(user_params)
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
      end
    end
    
    render json: {status: false}, status: :unprocessable_entity
    
  end

  def destroy
    user = User.find_by(id: params[:id])
    
    if user
      if user.destroy
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
      end
    else
      render json: {status: false}, status: :unprocessable_entity
    end
    
  end
  
  private 
  
  def user_params
    params.required(:user).permit(:name, :nickname, :picture, :email, :user_id, "user_id", "test")
  end
  
  def filter_params
    params.permit("user_id", "journy_id", "user_id": [], "journy_id": [])
  end
  
end

class V1::JourniesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    journies = Journey.all
    
    puts "Journey Controller - params: #{params}"
    if params["id"]
      journies = journies.where(id: params["id"])
    elsif params["user_id"]
      journies = journies.where(user_id: params["user_id"])
    elsif params["category_id"]
      journies = journies.where(category_id: params["category_id"])
    end
    
    render json: journies, status: :ok
  end

  def show
    journey = Journey.find_by(id: params[:id]) || nil
    
    render json: journey, status: :ok
  end
  
  def create
    puts "Journey params #{journey_params}"
    new_journey = Journey.create(journey_params)
    
    if new_journey.errors.count == 0
      render json: new_journey, status: :ok
    else
      render json: new_journey.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    journey = Journey.find_by(id: params[:id])
    
    unless journey.nil?
      if journey.update(journey_params)
        render json: journey, status: :ok and return
      else
        render json: journey.errors, status: 500 and return
      end
    end
    
    render json: {status: false}, status: :unprocessable_entity
    
  end

  def destroy
    journey = Journey.find_by(id: params[:id])
    
    if journey
      if journey.destroy
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
      end
    else
      render json: {status: false}, status: :unprocessable_entity
    end
    
  end
  
  private 
  
  def journey_params
    params.required(:journy).permit(:title, :description, :category_id, :user_id)
  end
  
end

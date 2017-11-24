class V1::JourniesController < ApplicationController
  def index
    journies = Journey.all
    
    render json: journies, status: :ok
  end

  def show
    journey = Journey.find_by(id: params[:id]) || nil
    
    render json: journey, status: :ok
  end
  
  def create
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
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
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
    params.required(:journey).permit(:title, :description, :category_id)
  end
  
end

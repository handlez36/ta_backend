class V1::CategoriesController < ApplicationController
  def index
    categories = Category.all
    
    render json: categories, status: :ok
  end

  def show
    category = Category.find_by(id: params[:id]) || nil
    
    render json: category, status: :ok
  end
  
  def create
    new_category = Category.create(category_params)
    
    if new_category.errors.count == 0
      render json: new_category, status: :ok
    else
      render json: {'error': true}.merge(new_category.errors.messages), status: :unprocessable_entity
    end
  end

  def update
    category = Category.find_by(id: params[:id])
    
    unless category.nil?
      if category.update(category_params)
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
      end
    end
    
    render json: {status: false}, status: :unprocessable_entity
    
  end

  def destroy
    category = Category.find_by(id: params[:id])
    
    if category
      if category.destroy
        render json: {status: true}, status: :ok and return
      else
        render json: {status: false}, status: 500 and return
      end
    else
      render json: {status: false}, status: :unprocessable_entity
    end
    
  end
  
  private 
  
  def category_params
    params.required(:category).permit(:name)
  end
end

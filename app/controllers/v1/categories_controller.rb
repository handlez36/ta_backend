class V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index    
    # categories = (filter_params.empty?) ?
    #   Category.all :
    #   Category.where(filter_params)

    categories = if filter_params.empty?
        Category.all
      else
        filter_params["wildcard"].present? ?
          search = "name ILIKE '%#{filter_params["name"]}%'" :
          search = filter_params
  
        Category.where(search)
      end
    
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
        render json: category, status: :ok and return
      else
        render json: category.errors, status: 500 and return
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
  
  def filter_params
    params.permit(
      "id",
      "name",
      "wildcard",
      "id": []
    )
  end
end

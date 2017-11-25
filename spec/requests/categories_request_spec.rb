require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  
  describe "GET #index" do
    
    it "returns http success" do
      category = Category.create!(name: 'Category1')
      get '/categories', {}, {Accept: Mime::JSON}
      
      categories = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime::JSON)
      expect(categories.first[:name]).to eq(category.name)
    end
    
    it "returns empty array with no categories present" do
      get '/categories', {}, {Accept: Mime::JSON}
      
      categories = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime::JSON)
      expect(categories).to eq([])
    end
  end
  
  describe "GET #show" do
    let! (:category1) { Category.create!(name: 'Category1') }
    let! (:category2) { Category.create!(name: 'Category2') }
    
    it "returns http success" do
      get "/categories/#{category1.id}"
      
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime::JSON)
    end
    
    it "returns the right category when requested" do
      get "/categories/#{category1.id}"
      
      categories = JSON.parse(response.body, symbolize_names: true)
      expect(categories[:name]).to eq(category1.name)
      
      get "/categories/#{category2.id}"
      
      category = JSON.parse(response.body, symbolize_names: true)
      expect(category[:name]).to eq(category2.name)
    end
    
    it "returns nil when no journey is found" do
      get "/journies/100"
      
      expect(response.body).to eq("null")
    end
  end

  context "with_params" do
    let! (:category) { Category.create!(name: "Category Name") }
    let! (:category_params) { { name: 'Sample category' } }
    let! (:invalid_category_params) { { name: nil } }
    
    describe "GET #create" do
    
      it "returns http success and successfully creates a category" do
        post '/categories', category: category_params

        category = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:success)
        expect(category[:name]).to eq(category_params[:name])
      end

      it "reports a proper error if category creation is unsuccessful" do
        post '/categories', category: invalid_category_params

        category = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(category[:name]).to eq(["can't be blank"])
      end
    
    end

    describe "GET #update" do
      it "returns http success and updates category" do
        put "/categories/#{category.id}", category: { name: "Updated Category" }
        
        expect(response).to have_http_status(:success)
        expect(category.reload.name).to eq("Updated Category")
      end
      
      it "returns an error when trying to update a non-existent category" do
        put "/categories/200", category: { name: "Updated Category" }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(category.reload.name).to eq("Category Name")
      end
    end
  end

  describe "GET #destroy" do
    let! (:category) { Category.create!(name: "Category Name") }
    
    it "returns http success and destroys the category" do
      delete "/categories/#{category.id}"
      
      expect(response).to have_http_status(:success)
      expect(Category.find_by(id: category.id)).to be_nil
    end
    
    it "returns an error when trying to delete a non-existent category" do
      delete "/categories/200"
        
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Category.all.count).to eq(1)
    end
  end

end

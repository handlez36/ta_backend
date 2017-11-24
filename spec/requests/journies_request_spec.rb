require 'rails_helper'

RSpec.describe "Journies API", type: :request do
  
  describe "GET #index" do
    let! (:category) { Category.create!(name: 'Category1') }
    
    it "returns http success" do
      journey = Journey.create!(title: 'Journey1', description: 'My first journey', category: category)
      
      get '/journies', {}, {Accept: Mime::JSON}
      
      journies = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime::JSON)
      expect(journies.first[:title]).to eq(journey.title)
    end
    
    it "returns empty array with no journies present" do
      get '/journies', {}, {Accept: Mime::JSON}
      
      journies = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime::JSON)
      expect(journies).to eq([])
    end
  end
  
  describe "GET #show" do
    let! (:category) { Category.create!(name: 'Category1') }
    let! (:journey1) { Journey.create!(title: 'Journey1', description: 'My first journey', category: category) }
    let! (:journey2) { Journey.create!(title: 'Journey1', description: 'My first journey', category: category) }
    
    it "returns http success" do
      get "/journies/#{journey1.id}"
      
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime::JSON)
    end
    
    it "returns the right journey when requested" do
      get "/journies/#{journey1.id}"
      
      journies = JSON.parse(response.body, symbolize_names: true)
      expect(journies[:title]).to eq(journey1.title)
      
      get "/journies/#{journey2.id}"
      
      journies = JSON.parse(response.body, symbolize_names: true)
      expect(journies[:title]).to eq(journey2.title)
    end
    
    it "returns nil when no journey is found" do
      get "/journies/100"
      
      expect(response.body).to eq("null")
    end
  end

  context "with_params" do
    let! (:category) { Category.create!(name: "Category Name") }
    let! (:journey) { Journey.create!(title: 'Journey1', description: 'My first journey', category: category) }
    let! (:journey_params) {
      { 
        title: 'Sample journey', 
        description: 'Journey description', 
        category_id: category.id
      }
    }
    let! (:invalid_journey_params) {
      { 
        description: 'Journey description', 
        category_id: category.id
      }
    }
    
    describe "GET #create" do
    
      it "returns http success and successfully creates a journey" do
        post '/journies', journey: journey_params

        journey = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:success)
        expect(journey[:title]).to eq(journey_params[:title])
      end

      it "reports a proper error if journey creation is unsuccessful" do
        post '/journies', journey: invalid_journey_params

        journey = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(journey[:title]).to eq(["can't be blank"])
      end
    
    end

    describe "GET #update" do
      it "returns http success and updates journey" do
        put "/journies/#{journey.id}", journey: { title: "Updated Journey" }
        
        expect(response).to have_http_status(:success)
        expect(journey.reload.title).to eq("Updated Journey")
      end
      
      it "returns an error when trying to update a non-existent journey" do
        put "/journies/200", journey: { title: "Updated Journey" }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(journey.reload.title).to eq("Journey1")
      end
    end
  end

  describe "GET #destroy" do
    let! (:category) { Category.create!(name: "Category Name") }
    let! (:journey) { Journey.create!(title: 'Journey1', description: 'My first journey', category: category) }
    
    it "returns http success and destroys the journey" do
      delete "/journies/#{journey.id}"
      
      expect(response).to have_http_status(:success)
      expect(Journey.find_by(id: journey.id)).to be_nil
    end
    
    it "returns an error when trying to delete a non-existent journey" do
      delete "/journies/200"
        
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Journey.all.count).to eq(1)
    end
  end

end

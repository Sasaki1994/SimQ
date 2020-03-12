require 'rails_helper'

describe QuestionsController do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #search' do
    it 'renders json as success' do
      get :search, params: {question: {url: "https://master.tech-camp.in/curriculums/1183", text: "hamlが分からない"}}
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
    end

    it 'renders json as fail when url is "" ' do
      post :search, params: {question: {url: "", text: "hamlが分からない"}}
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
    end

    it 'renders json as fail when text is "" ' do
      post :search, params: {question: {url: "https://master.tech-camp.in/curriculums/1183", text: ""}}
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
    end

    it 'renders json as fail when url is wrong format ' do
      post :search, params: {question: {url: "https:///hoge.com", text: "hamlが分からない"}}
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
    end


  end
      
end 
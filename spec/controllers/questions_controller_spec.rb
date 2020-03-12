require 'rails_helper'

describe QuestionsController do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #search' do
    it 'renders partial response as success' do
      get :search, params: {question: {url: "https://master.tech-camp.in/curriculums/1183", text: "hamlが分からない"}}
      expect(response).to render_template partial: '_response'
    end

    it 'renders partial response as fail by url none' do
      get :search, params: {question: {url: "", text: "haml"}}
      expect(response).to render_template partial: '_response'
    end

    it 'renders partial response as fail by text' do
      get :search, params: {question: {url: "https://master.tech-camp.in/curriculums/1183", text: ""}}
      expect(response).to render_template partial: '_response'
    end

    it 'renders partial response as fail by url type' do
      get :search, params: {question: {url: "https://yahoo.co.jp", text: ""}}
      expect(response).to render_template partial: '_response'
    end

    it 'renders partial response as fail by no similar question' do
      get :search, params: {question: {url: "https://master.tech-camp.in/curriculums/1183", text: "qwertyuiopasdfghj"}}
      expect(response).to render_template partial: '_response'
    end

  end
      
end 
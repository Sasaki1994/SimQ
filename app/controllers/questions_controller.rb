class QuestionsController < ApplicationController
  require 'net/http'
  require 'uri'
  
  def index
  end

  def search
    question = {}
    question[:curriculum_id] = extract_cur_id(question_params[:url])
    question[:text] = question_params[:text]
    response = post2api(question)
    body = JSON.parse(response.body)
    if body["success"] == true 
      body["text"] = body["text"].map do |text|
        view_context.simple_format(text)
      end
      render :json => body
    else
      render :json => body
    end
  end

  private
  def question_params
    params.require(:question).permit(:url, :text)
  end

  def extract_cur_id(url)
    reg = url.match(/https:\/\/master.tech-camp.in\/curriculums\/(\d+)$/)
    curriculum_id = reg ? reg[1] : nil
    return curriculum_id
  end

  def post2api(question)
    target_uri = "http://127.0.0.1:5000/predict"
    uri = URI.parse(target_uri)

    req = Net::HTTP::Post.new(uri)
    req.body = question.to_json
    req["Content-Type"] = 'application/json'

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end

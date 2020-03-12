class QuestionsController < ApplicationController
  require 'net/http'
  require 'uri'
  
  def index
  end

  # ajaxを用いた類似質問探索アクション
  # params: 質問:{url: "<TMカリキュラムURL>", text: "<質問内容>"}
  # return: 類似質問:type/json {success: bool, n_items: <類似質問数>, text: [<類似質問テキスト>]} 
  def search
    # URLをカリキュラムIDに変換、パラメータ格納変数を移動
    question = {} 
    question[:curriculum_id] = extract_cur_id(question_params[:url])
    question[:text] = question_params[:text]

    # 機械学習APIへ質問をPOST -> JSON
    response = post2api(question)
    body = JSON.parse(response.body)

    # 後置ifに変更可能
    if body["success"] == true
      # 返却テキストの整形
      body["text"] = body["text"].map do |text|
        view_context.simple_format(text)
      end
      render :json => body
    else
      render :json => body
    end
  end

  private
  # strong parameter
  def question_params
    params.require(:question).permit(:url, :text)
  end

  # TMのURLをカリキュラムIDに変換
  def extract_cur_id(url)
    # URLの下番号部分を抽出
    reg = url.match(/https:\/\/master.tech-camp.in\/curriculums\/(\d+)$/)
    curriculum_id = reg ? reg[1] : nil
    return curriculum_id
  end

  # 機械学習APIへのPOSTリクエスト
  def post2api(question)
    # param: question(type: hash) {curriculum_id: "<TM curriculum id>", text: "question text"}
    # return: similar questions(type: json) {success: bool, n_items: num of sim. questions, text: [similar question text]}

    #機械学習APIのリクエストURL
    host = "http://127.0.0.1:5000"
    target_uri = host + "/predict"
    uri = URI.parse(target_uri)

    # リクエストパラメータの設定
    req = Net::HTTP::Post.new(uri)
    req.body = question.to_json
    req["Content-Type"] = 'application/json'

    # POSTリクエストを送信し、レスポンスを返す
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end

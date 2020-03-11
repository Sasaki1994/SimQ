class QuestionsController < ApplicationController
  def index
    @responses = []
    5.times do
      @responses << generate
    end
  end

  private
  def generate
    text='【質問の箇所】
    基礎カリキュラム
    https://master.tech-camp.in/curriculums/3623
  【質問の種類】
    実装の相談(エラーが出る/思い通りの表示ができない)
  【質問の内容】
    ■ エラー画面のスクリーンショット
    
    ■ 問題に関するVScodeのファイル全体のスクリーンショット
    
    ■ 問題に関するターミナルやコンソールのスクリーンショット
    nil>]>
  irb(main):003:0> Post.find(1)
    Post Load (0.3ms)  SELECT  `posts`.* FROM `posts` WHERE `posts`.`id` = 1 LIMIT 1
  => #<Post id: 1, content: "これはあああ", created_at: "2020-02-22 00:00:00", updated_at: "2020-02-22 00:00:00">
  irb(main):004:0> post
  Traceback (most recent call last):
          1: from (irb):4
  NameError (undefined local variable or method `post\' for main:Object)
  irb(main):005:0> post
  Traceback (most recent call last):
          1: from (irb):5
  NameError (undefined local variable or method `post\' for main:Object)
  irb(main):006:0> Post.find(1)
    Post Load (0.8ms)  SELECT  `posts`.* FROM `posts` WHERE `posts`.`id` = 1 LIMIT 1
  => #<Post id: 1, content: "これはあああ", created_at: "2020-02-22 00:00:00", updated_at: "2020-02-22 00:00:00">
  irb(main):007:0> post
  Traceback (most recent call last):
          1: from (irb):7
  NameError (undefined local variable or method `post\' for main:Object)
  irb(main):008:0> 

    ■ 確認したいことに関連する画面のスクリーンショット
    
    ■ 解決したいこと
    変数ポストに代入できない
    ■ 調べた内容とそこから立てた仮説
    入力漏れ
    ■ 仮説を元に行った作業内容 
    一つ前のコードを入れてみた'
    return text
  end

end

$(function(){

  // 類似質問レスポンスを描画するテンプレート
  function buildResHTML(text){
    html = `\
    <div class="response">\
      <div class="response__body">\
      　${text}\
      </div>\
    </div>`;
    $('.main').append(html)
  }

  // 質問内容フォームのオートリサイズ
  $("textarea").autosize();
  
  // 類似質問を探す
  $("#submit").on("click", function(e){
    e.preventDefault();　// デフォルト動作の棄却. 現在のビュー仕様上不要
    let part = $("#qpart").val(); // URL
    let detail = $("#qdetail").val(); // 質問内容
    $('.response').remove(); // 2回目以降のためのリセット

    $.ajax({
      // questions controller # search action
      type: 'GET',
      url:  '/questions',
      data: {
        question: {
          url: part,
          text: detail
        }
      },
      dataType: 'json'
    })
    .done(function(event){
      // event: {success: bool, n_item: <num of sim questions>, text: [ <sim question texts> ]}
      if (event["success"] == true){
        if (event["n_item"] > 0){
          for(let text of event["text"]) {
            buildResHTML(text);
          }
        }else{
          let noItemText =　"<p>類似の質問が見つかりませんでした</p></br>"
          buildResHTML(noItemText);
        }
      }else{
        let failText =　"<p>質問の探索に失敗しました。</br>質問の箇所と質問内容を確認してください。</p></br>"
        buildResHTML(failText);
      }
      // 自動スクロール
      $("html,body").animate({scrollTop:$('.response').offset().top - 90}); // 90:微調整
    });
  });

});

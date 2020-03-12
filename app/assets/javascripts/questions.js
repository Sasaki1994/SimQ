$(function(){

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
      dataType: 'html'
    })
    .done(function(event){
      // event: html as rendered by _response.html.haml
      $('.main').append(event)
      
      // 自動スクロール
      $("html,body").animate({scrollTop:$('.response').offset().top - 90}); // 90:微調整
    });

    
  });

});

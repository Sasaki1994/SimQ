$(function(){
  function buildFailHTML(){
    html = `\
    <div class="response">\
      <div class="response__body">\
      　<p>質問の探索に失敗しました。</br>質問の箇所と質問内容を確認してください。</p>\
        </br>
      </div>\
    </div>`;
    return html
  }

  function buildNoResHTML(){
    html = `\
    <div class="response">\
      <div class="response__body">\
      　<p>類似の質問が見つかりませんでした</p>
        </br>
      </div>\
    </div>`;
    return html
  }

  function buildResHTML(text){
    html = `\
    <div class="response">\
      <div class="response__body">\
      　${text}\
      </div>\
    </div>`;
    return html
  }

  $("textarea").autosize();

  $("#submit").on("click", function(e){
    e.preventDefault();
    let part = $("#qpart").val();
    let detail = $("#qdetail").val();
    $('.response').remove();
    $.ajax({
      type: 'POST',
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
      if (event["success"] == true){
        if (event["n_item"] > 0){
          for(let text of event["text"]) {
            let response = buildResHTML(text);
            $('.main').append(response);
          }
        }else{
          let response = buildNoResHTML();
          $('.main').append(response);
        }
      }else{
        let response = buildFailHTML();
        $('.main').append(response);
      }
      $("html,body").animate({scrollTop:$('.response').offset().top - 90});
    })
  });

});

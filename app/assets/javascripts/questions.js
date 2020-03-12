$(function(){
  

  function buildHTML(text){
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
      for(let text of event["text"]) {
        response = buildHTML(text);
        $('.main').append(response);
      }
      $("html,body").animate({scrollTop:$('.response').offset().top - 90});
    })
  });

});

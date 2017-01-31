$(document).on('turbolinks:load', function(){
  $(".flip-button").on("click", function(){
    $(".back-cards").toggle();
    $(".flip-button").toggle();
  })
})
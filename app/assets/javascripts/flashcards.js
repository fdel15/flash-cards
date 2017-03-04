function display_cards(cards) {
  var html = "<div class='display_cards'>"

  for ( var i = 0; i < cards.length; i++) {
      if ( cards[i].back ) { continue; }
      html += "<div class='front-cards'>"
      if ( i === 0 || i === 1 ) { html += "<h2>Front</h2>" }
      html += display_card(cards[i])
      html += "</div>"
      html += "<div class='back-cards'>"
      if ( i === 0 || i === 1) { html += "<h2>Back</h2>" }
      html += display_card(get_card(cards, cards[i].flip_side_id))
      html += "</div>"
  }

  html += "</div>"
  return html
}

function get_card(cards, id) {
  var card;
  for ( i = 0; i < cards.length; i++ ) {
    if ( cards[i].id === id ) { card = cards[i]}
    if ( card ) { break; }
  }
  return card;
}

function display_card(card) {
  return  "<div class='card streak-" + card.streak + "'>" + card.description + "</div>" +
          edit_button(card.id) + delete_button(card.id)
}

function edit_button(card_id) {
  return "<button class='btn btn-primary edit-delete'><a href='/cards/" + card_id + "/edit'>Edit</a></button>"
}

function delete_button(card_id) {
  return "<button class='btn btn-danger edit-delete'><a data-confirm='Are you sure?'' rel='nofollow' data-method='delete' href='/cards/" + card_id + "'>Delete</a></button>"
}

function update_review_cards_link(category) {
  $("#review-cards-btn").attr("href", "/new_review_session?category=" + category)
}

$(document).on('turbolinks:load', function(){
  $(".flip-button").on("click", function(){
    $(".back-cards").toggle();
    $(".flip-button").toggle();
  })

  $("#category_category_id").change(function(){
    update_review_cards_link(this.value)
    $.ajax({
      type: "GET",
      url: "/cards?category=" + this.value,
      dataType: "json"
    })
    .done(function( data ) {
      $('.display_cards').html(display_cards(data))
    })
  })
})



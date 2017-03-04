module ApplicationHelper
  def display_card_header(side, index)
    return unless index == 0
    "<h2>#{ side }</h2>".html_safe
  end

  def category_select_value
    params[:category] ? params[:category][:category_id] : 0
  end

  def find_card(cards, card_id)
    cards.find{|card| card.id == card_id }
  end

  def display_card(card)
    streak = card.streak >= 10 ? 10 : card.streak
    "<div class='card streak-#{ streak }'>
      #{ card.description.html_safe }
      </div>".html_safe
  end
end

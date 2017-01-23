module ApplicationHelper
  def display_card_header(side, index)
    return unless index == 0
    "<h2>#{ side }</h2>".html_safe
  end

  def category_select_value
    params[:category] ? params[:category][:category_id] : 0
  end

  def get_card_ids(cards)
    cards.map{|card| card.id }
  end

  def flip_side
   @card = Card.find(@card.flip_side_id)
   render :template => "cards/show" 
  end
end

module ApplicationHelper
  def display_card_header(side, index)
    return unless index == 0
    "<h2>#{ side }</h2>".html_safe
  end
end

class CardsController < ApplicationController

  def index
    @cards = Card.all
    @categories = Category.all
  end

  def new
    @categories = Category.all
  end

  def create
    front  = Card.new(description: card_params[:front], category_id: card_params[:category], front: 1)
    back   = Card.new(description: card_params[:back], category_id: card_params[:category], back: 1)

    if front.valid? && back.valid?
      front.save
      back.other_side_of_card_fk = front.id
      back.save
      front.update!(other_side_of_card_fk: back.id)
      redirect_to root_path
    else
      flash[:error] = "Oops something went wrong! Try again"
      redirect_to :back
    end
  end

  def review
    category = params[:review_cards][:category].to_i
    if category > 0
      @cards = Card.where("category_id = ? ", category)
    else
      @cards = Card.all  
    end
      @categories = Category.all
      render :index
  end

  private

  def card_params
    params.require(:card).permit(:category, :front, :back )
  end

end
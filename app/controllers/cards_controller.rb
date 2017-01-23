class CardsController < ApplicationController

  def index
    category = params[:category]
    if category && category[:category_id] != ""
      @front_cards = Card.where("front = ? AND category_id = ?", true, category[:category_id])
    else
      @front_cards = Card.where(front: true)
    end
      @categories = Category.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @categories = Category.all
  end

  def create
    front  = Card.new(description: card_params[:front], category_id: card_params[:category_id], front: 1)
    back   = Card.new(description: card_params[:back], category_id: card_params[:category_id], back: 1)
    if front.valid? && back.valid?
      front.save
      back.flip_side_id = front.id
      back.save
      front.update!(flip_side_id: back.id)
      redirect_to root_path
    else
      flash[:error] = "Oops something went wrong! Try again"
      redirect_to :back
    end
  end

  def edit
    @card = Card.find(params[:id])
    @categories = Category.all
  end

  def update
    card = Card.find(params[:id])
    if card.update(card_params)
      card.keep_flip_category_in_sync
      flash[:success] = "Card Updated!"
    else
      flash[:error] = "Oops something went wrong! Card not updated"
    end
    redirect_to cards_path
  end

  def destroy
    card = Card.find(params[:id])
    flip_side = Card.find(card.flip_side_id)
    card.destroy
    flip_side.destroy
    redirect_to cards_path
  end

  def new_review_session
    @review_cards = params[:cards].shuffle
    @index = 0
    @card = Card.find(@review_cards[@index])
    render :review_card
  end

  private

  def card_params
    params.require(:card).permit(:category_id, :front, :back, :id, :description )
  end

end
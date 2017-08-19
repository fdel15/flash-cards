class CardsController < ApplicationController
before_action :get_categories, only: [:index, :new, :edit]

  def index
    @category = params[:category]
    @cards = Card.get_cards_by_category(@category)

    respond_to do |format|
      format.html
      format.json { render json: @cards }
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
  end

  def create
    front  = Card.new(description: card_params[:front], category_id: card_params[:category_id], front: 1)
    back   = Card.new(description: card_params[:back], category_id: card_params[:category_id], back: 1)

    if front.valid? && back.valid?
      Card.save_cards(front, back)
      redirect_to root_path
    else
      flash[:error] = "Oops something went wrong! Try again"
      redirect_to :back
    end
  end

  def edit
    @card = Card.find(params[:id])
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
    card.delete
    redirect_to cards_path
  end

  def new_review_session
    review_cards = Card.get_review_cards(params[:category]).shuffle
    session[:index] = 0
    review_card(review_cards)
  end

  def next_card
    last_card = Card.find(params[:card])
    last_card.update_streak(params[:correct])

    session[:index] += 1

    return redirect_to cards_path if end_of_session
    review_card(params[:review_cards])
  end

  def review_card(review_cards)
    @review_cards = review_cards
    @front = Card.find(@review_cards[session[:index]])
    @back = Card.find(@front.flip_side_id)
    render :review_card
  end

  def end_of_session
    session[:index] >= params[:review_cards].length
  end

  private

  def card_params
    params.require(:card).permit(:category_id, :front, :back, :id, :description )
  end

  def get_categories
    @categories = Category.all
  end

end
class CardsController < ApplicationController

  def index
    @category = params[:category]
    @cards = get_cards_by_category
    @categories = Category.all

    respond_to do |format|
      format.html
      format.json { render json: @cards }
    end
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
    byebug
    cards = Card.get_cards_by_category(params[:category])
    @review_cards = cards.select{ |card| card.front }.shuffle()
    session[:index] = 0
    @front = Card.find(@review_cards[session[:index]])
    @back = Card.find(@front.flip_side_id)
    render :review_card
  end

  def next_card
    last_card = Card.find(params[:card])
    last_card.update_streak(params[:correct])

    @review_cards = params[:review_cards]
    session[:index] += 1
    return redirect_to cards_path if end_of_session
    @front = Card.find(@review_cards[session[:index]])
    @back = Card.find(@front.flip_side_id)
    render :review_card
  end

  def end_of_session
    session[:index] >= @review_cards.length
  end

  private

  def card_params
    params.require(:card).permit(:category_id, :front, :back, :id, :description )
  end

end
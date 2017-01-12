class FlashCardsController < ApplicationController
  
  def new_category
  end

  def create_category
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category created!'
    else
      flash[:error] = 'Oops something went wrong! Try again'
    end
    redirect_to root_path
  end

  def edit_category
  end

  def new_card
    @categories = Category.all
  end

  def create_card

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

  def edit_card
  end

  private

  def category_params
    params.require(:category).permit(:description)
  end

  def card_params
    params.require(:card).permit(:category, :front, :back )
  end
  
end
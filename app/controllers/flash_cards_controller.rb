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

  private

  def category_params
    params.require(:category).permit(:description)
  end
  
end
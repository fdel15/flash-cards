class CategoriesController < ApplicationController

  def new
  end

  def create
    @category = Category.new(category_params)
    if @category.valid?
      category.save
      flash[:success] = 'Category created!'
    else
      flash[:error] = 'Oops something went wrong! Try again'
    end
    redirect_to root_path
  end

  private

  def category_params
    params.require(:category).permit(:description)
  end

end
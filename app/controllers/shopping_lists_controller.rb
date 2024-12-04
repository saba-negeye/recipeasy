class ShoppingListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_list, only: [:show, :edit, :update]

  def show
    # No need to explicitly define @shopping_list here, it's set by the before_action
  end

  def edit
  end

  def update
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_path(@shopping_list), notice: 'Shopping list updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_shopping_list
    @shopping_list = current_user.shopping_list
    redirect_to root_path, alert: 'You do not have a shopping list.' unless @shopping_list
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:name)
  end
end


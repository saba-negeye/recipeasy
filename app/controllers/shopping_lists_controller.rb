class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: [:show, :edit, :update, :destroy]

  # Show the shopping list
  def show
    @shopping_list_ingredient = @shopping_list.shopping_list_ingredients.build
  end

  # Create a new shopping list or add an ingredient
  def create
    ingredient = Ingredient.find(params[:ingredient_id])
    if @shopping_list.ingredients.include?(ingredient)
      redirect_to ingredients_path, alert: "#{ingredient.name} is already in your shopping list."
    else
      @shopping_list.ingredients << ingredient
      redirect_to ingredients_path, notice: "#{ingredient.name} was added to your shopping list."
    end
  end

  # Edit the shopping list
  def edit
    @shopping_list_ingredient = @shopping_list.shopping_list_ingredients.build
  end

  # Update the shopping list
  def update
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_path(@shopping_list), notice: 'Shopping list was successfully updated.'
    else
      render :edit
    end
  end

  # Remove an ingredient from the shopping list
  def destroy
    @shopping_list_ingredient = ShoppingListIngredient.find(params[:id])
    if @shopping_list_ingredient.destroy
      redirect_to shopping_list_path(@shopping_list), notice: 'Ingredient was successfully removed.'
    else
      redirect_to shopping_list_path(@shopping_list), alert: 'Failed to remove the ingredient.'
    end
  end

  private

  # Set the shopping list for actions
  def set_shopping_list
    @shopping_list = current_user.shopping_list || current_user.create_shopping_list
  end

  # Permit parameters for updating the shopping list
  def shopping_list_params
    params.require(:shopping_list).permit(
      :name,
      shopping_list_ingredients_attributes: [:id, :ingredient_id, :quantity, :_destroy]
    )
  end
end




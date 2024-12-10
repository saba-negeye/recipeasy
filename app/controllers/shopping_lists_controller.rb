class ShoppingListsController < ApplicationController
  def show
    @shopping_list = current_user.shopping_list
  end
  def create
    ingredient = Ingredient.find(params[:ingredient_id])
    if @shopping_list.ingredients.include?(ingredient)
      redirect_to ingredients_path, alert: "#{ingredient.name} is already in your shopping list."
    else
      @shopping_list.ingredients << ingredient
      redirect_to ingredients_path, notice: "#{ingredient.name} was added to your shopping list."
    end
  end
  def destroy
    @shopping_list_ingredient = ShoppingListIngredient.find(params[:id])
    @shopping_list_ingredient.destroy
    redirect_to shopping_list_path(@shopping_list), notice: 'Ingredient was successfully removed.'
  end
  
  def set_shopping_list
    @shopping_list = current_user.shopping_list || current_user.create_shopping_list
  end

end



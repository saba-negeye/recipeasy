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
  #adds saved recipes to shopping list
  def add_recipe_ingredients_to_shopping_list(recipe)
    recipe.ingredients.each do |ingredient|
      shopping_list_ingredient = current_user.shopping_list.shopping_list_ingredients.find_or_initialize_by(ingredient: ingredient)
      shopping_list_ingredient.quantity ||= 0
      shopping_list_ingredient.quantity += ingredient.recipe_ingredients.find_by(recipe: recipe).quantity
      shopping_list_ingredient.save
    end
  end
  #manually add ingredients
  def create
    ingredient = Ingredient.find_or_create_by(name: params[:shopping_list_ingredient][:name])
    shopping_list_ingredient = current_user.shopping_list.shopping_list_ingredients.find_or_initialize_by(ingredient: ingredient)
    shopping_list_ingredient.quantity ||= 0
    shopping_list_ingredient.quantity += params[:shopping_list_ingredient][:quantity].to_f
    shopping_list_ingredient.save
    redirect_to shopping_list_path(current_user.shopping_list), notice: "Ingredient added to shopping list."
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


class ShoppingListIngredientsController < ApplicationController
    before_action :set_shopping_list
    before_action :set_shopping_list_ingredient, only: [:update]
    

    def show
        @shopping_list = ShoppingList.find(params[:id])
        @shopping_list_ingredient = @shopping_list.shopping_list_ingredients.build
    end

    def create
      @shopping_list_ingredient = @shopping_list.shopping_list_ingredients.build(shopping_list_ingredient_params)
      
      if @shopping_list_ingredient.save
        redirect_to @shopping_list, notice: 'Ingredient was successfully added.'
      else
        render 'shopping_lists/show'
      end
    end
  
    def update
      if @shopping_list_ingredient.update(shopping_list_ingredient_params)
        redirect_to @shopping_list, notice: 'Ingredient was successfully updated.'
      else
        render 'shopping_lists/show'
      end
    end
  
    private
  
    def set_shopping_list
      @shopping_list = ShoppingList.find(params[:shopping_list_id])
    end
  
    def set_shopping_list_ingredient
      @shopping_list_ingredient = ShoppingListIngredient.find(params[:id])
    end
  
    def shopping_list_ingredient_params
      params.require(:shopping_list_ingredient).permit(:name, :quantity, :unit)
    end
  end
  
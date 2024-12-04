class RecipesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  
    def index
      @recipes = current_user.recipes
      
    end
  
    def show
    end
  
    def new
      @recipe = current_user.recipes.build
    end
  
    def create
      @recipe = current_user.recipes.build(recipe_params)
      if @recipe.save
        redirect_to recipes_path, notice: 'Recipe was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @recipe.update(recipe_params)
        redirect_to @recipe, notice: 'Recipe was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
    end
  
    private
  
    # Ensure the @recipe instance variable is set for the required actions
    def set_recipe
      @recipe = current_user.recipes.find_by(id: params[:id])
      unless @recipe
        redirect_to recipes_path, alert: 'Recipe not found or you do not have access to it.'
      end
    end
  
    # Strong parameters to allow only specific attributes
    def recipe_params
      params.require(:recipe).permit(:title, :description, :cooking_steps, recipe_ingredients_attributes: [:ingredient_id, :quantity])
    end
  end
  
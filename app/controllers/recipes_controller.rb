class RecipesController < ApplicationController
    before_action :authenticate_user!

    def index
      @recipes = current_user.recipes
    end
  
    def show
        @recipe = Recipe.find(params[:id])
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
        @recipe = Recipe.find(params[:id])
    end
  
    def update
        @recipe = Recipe.find(params[:id])
      if @recipe.update(recipe_params)
        redirect_to @recipe, notice: 'Recipe was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
    end
  
    private

  
    def recipe_params
     params.require(:recipe).permit(:title, :description, :cooking_steps, recipe_ingredients_attributes: [:ingredient_id, :quantity])
    end
      
  end
  
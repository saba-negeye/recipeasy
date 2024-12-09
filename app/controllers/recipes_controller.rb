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

    # Additional handling for API data if not covered by recipe_params
    if request.format.json? && params[:ingredients]
      params[:ingredients].each do |ingredient_data|
        ingredient = Ingredient.find_or_create_by(name: ingredient_data[:name])
        @recipe.recipe_ingredients.build(ingredient: ingredient, quantity: ingredient_data[:quantity])
      end
    end

    if @recipe.save
      respond_to do |format|
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
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
    params.require(:recipe).permit(:title, :description, recipe_ingredients_attributes: [:ingredient_id, :quantity])
  end
end

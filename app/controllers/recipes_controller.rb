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
    # Check if recipe data is coming from the form submission or the API
    if params[:recipe][:api_recipe_id].present?
      # Handle API recipe
      recipe_data = fetch_api_recipe(params[:recipe][:api_recipe_id])
      @recipe = current_user.recipes.build(
        title: recipe_data[:title],
        description: recipe_data[:description],
        cooking_steps: recipe_data[:cooking_steps]
      )

      # Save ingredients from the API
      recipe_data[:ingredients].each do |ingredient_data|
        ingredient = Ingredient.find_or_create_by(name: ingredient_data[:name])
        RecipeIngredient.create(recipe: @recipe, ingredient: ingredient, quantity: ingredient_data[:quantity])
      end
    else
      # Handle form-submitted recipe
      @recipe = current_user.recipes.build(recipe_params)
    end

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

  def set_recipe
    @recipe = current_user.recipes.find_by(id: params[:id])
    unless @recipe
      redirect_to recipes_path, alert: 'Recipe not found or you do not have access to it.'
    end
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :cooking_steps, recipe_ingredients_attributes: [:ingredient_id, :quantity])
  end

  # Method to fetch the API recipe data
  def fetch_api_recipe(api_recipe_id)
    api_key = "YOUR_SPOONACULAR_API_KEY"
    url = "https://api.spoonacular.com/recipes/#{api_recipe_id}/information?apiKey=#{api_key}"

    response = Net::HTTP.get(URI(url))
    recipe_data = JSON.parse(response)

    {
      title: recipe_data["title"],
      description: recipe_data["summary"], # Assuming 'summary' is the description
      cooking_steps: recipe_data["instructions"],
      ingredients: recipe_data["extendedIngredients"].map do |ingredient|
        { name: ingredient["name"], quantity: ingredient["amount"], unit: ingredient["unit"] }
      end
    }
  end
end

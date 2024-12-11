class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # Handles form-based recipe creation
  def create_from_form
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def create_from_api
    ActiveRecord::Base.transaction do
      # Step 1: Add ingredients to the database or find existing ones
      ingredients = params[:recipe][:recipe_ingredients_attributes].values.map do |ingredient_data|
        Ingredient.find_or_create_by!(
          spoonacular_id: ingredient_data[:ingredient_id] # Match by spoonacular_id
        ) do |ingredient|
          # Set name and unit_of_measurement for new ingredients
          ingredient.name = ingredient_data[:name]
          ingredient.unit_of_measurement = ingredient_data[:unit]
        end
      end
  
      # Step 2: Create the recipe
      @recipe = current_user.recipes.create!(
        title: params[:recipe][:title],
        description: params[:recipe][:description]
      )
  
      # Step 3: Create recipe_ingredients
      params[:recipe][:recipe_ingredients_attributes].values.each do |ingredient_data|
        ingredient = ingredients.find { |i| i.spoonacular_id == ingredient_data[:ingredient_id].to_i }
        @recipe.recipe_ingredients.create!(
          ingredient: ingredient,
          quantity: ingredient_data[:amount]
        )
      end
    end
  
    render json: { message: 'Recipe was successfully created.', recipe: @recipe }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
  
  # API-based recipe creation
  # def create_from_api
  #   ActiveRecord::Base.transaction do
  #     # Step 1: Add ingredients to the database
  #     puts '............................'
  #     puts params
  #     ingredients = params[:ingredients].map do |ingredient_data|
  #       Ingredient.find_or_create_by!(
  #         name: ingredient_data[:name]
  #       ).tap do |ingredient|
  #         ingredient.update!(unit_of_measurement: ingredient_data[:unit]) if ingredient.unit_of_measurement.blank?
  #       end
  #     end
  #     # create the recipe
  #     @recipe = current_user.recipes.create!(
  #       title: params[:title],
  #       description: params[:description]
  #     )

  #     # create recipe_ingredients
  #     ingredients.each do |ingredient|
  #       @recipe.recipe_ingredients.create!(
  #         ingredient: ingredient,
  #         quantity: matching_ingredient_data[:amount]

  #       )
  #     end
  #   end

  #   render json: { message: 'Recipe was successfully created.', recipe: @recipe }, status: :created
  # rescue ActiveRecord::RecordInvalid => e
  #   render json: { error: e.message }, status: :unprocessable_entity
  # end

  # Other actions remain unchanged

  def index
    @recipes = current_user.recipes
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
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
    params.require(:recipe).permit(:title, :description, recipe_ingredients_attributes: [:id, :ingredient_id, :ingredient_name, :quantity,:ingredient_unit_of_measurement, :_destroy])
  end
end

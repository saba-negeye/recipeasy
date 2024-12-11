class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show edit update destroy]

  def index
    @ingredients = Ingredient.all
    @shopping_list = current_user.shopping_list || current_user.create_shopping_list
  end

  def show
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to @ingredient, notice: "Ingredient was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient, notice: "Ingredient was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to ingredients_url, notice: "Ingredient was successfully destroyed."
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end



  def ingredient_params
    params.require(:ingredient).permit(:name, :unit_of_measurement)
  end
end

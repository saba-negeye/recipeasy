class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient, optional: true

  attr_accessor :ingredient_name
  before_validation :find_or_create_ingredient

  validates :quantity, presence: true
  validates :ingredient, presence: true

  private

  def find_or_create_ingredient
    # If ingredient_name is provided, find or create the ingredient
    if ingredient_name.present?
      self.ingredient = Ingredient.find_or_create_by(name: ingredient_name.strip)
    end
  end
end

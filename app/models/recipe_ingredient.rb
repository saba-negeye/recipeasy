class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient, optional: true

  attr_accessor :ingredient_name
  attr_accessor :ingredient_unit_of_measurement
  before_create :find_or_create_ingredient

  

  private

  def find_or_create_ingredient
    # If ingredient_name is provided, find or create the ingredient
    puts '.....................'
    puts ingredient_name
    puts ingredient_unit_of_measurement
    if ingredient_id.blank? && ingredient_name.present?
      self.ingredient = Ingredient.find_or_create_by(name: ingredient_name.strip, unit_of_measurement: ingredient_unit_of_measurement)
    end
  end
end

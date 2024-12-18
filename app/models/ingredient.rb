class Ingredient < ApplicationRecord
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    has_many :shopping_list_ingredients, dependent: :destroy
    has_many :shopping_lists, through: :shopping_list_ingredients

    validates :name, presence: true
    validates :unit_of_measurement, presence: true
end

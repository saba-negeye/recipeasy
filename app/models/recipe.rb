class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :description, presence: true
  validates :cooking_steps, presence: true

  accepts_nested_attributes_for :recipe_ingredients
end

class RemoveCookingStepsFromRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_column :recipes, :cooking_steps, :text
  end
end
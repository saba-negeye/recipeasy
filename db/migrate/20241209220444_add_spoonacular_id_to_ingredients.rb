class AddSpoonacularIdToIngredients < ActiveRecord::Migration[7.2]
  def change
    add_column :ingredients, :spoonacular_id, :integer
    add_index :ingredients, :spoonacular_id, unique: true
  end
end

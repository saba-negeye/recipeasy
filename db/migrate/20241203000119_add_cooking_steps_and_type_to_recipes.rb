class AddCookingStepsAndTypeToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :cooking_steps, :text
    add_column :recipes, :type, :string
  end
end

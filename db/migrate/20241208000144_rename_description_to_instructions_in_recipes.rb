class RenameDescriptionToInstructionsInRecipes < ActiveRecord::Migration[7.2]
  def change
    rename_column :recipes, :description, :instructions
  end
end

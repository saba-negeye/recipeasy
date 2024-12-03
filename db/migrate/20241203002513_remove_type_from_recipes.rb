class RemoveTypeFromRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_column :recipes, :type, :string
  end
end

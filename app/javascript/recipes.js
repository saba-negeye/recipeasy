document.addEventListener("DOMContentLoaded", () => {
    console.log("JavaScript loaded");
    const addIngredientButton = document.getElementById("add-ingredient");
    const ingredientsList = document.getElementById("ingredients-list");
  
    if (addIngredientButton) {
    console.log("Add Ingredient button found");
      addIngredientButton.addEventListener("click", () => {
        const ingredientFields = `
          <div class="nested-fields">
            <div class="form-group">
              <label for="ingredient_name">Ingredient Name</label>
              <input type="text" name="recipe[recipe_ingredients_attributes][][ingredient_name]" class="form-control" placeholder="e.g., Sugar" />
            </div>
            <div class="form-group">
              <label for="quantity">Quantity</label>
              <input type="text" name="recipe[recipe_ingredients_attributes][][quantity]" class="form-control" placeholder="e.g., cups" />
            </div>
            <div class="form-group">
              <label for="ingredient_unit_of_measurement">Unit of Measurement</label>
              <input type="text" name="recipe[recipe_ingredients_attributes][][ingredient_unit_of_measurement]" class="form-control" placeholder="e.g., cups" />
            </div>
          </div>
        `;
        ingredientsList.insertAdjacentHTML("beforeend", ingredientFields);
      });
    } else {
        console.log("Add Ingredient button not found");
      }
  });
  
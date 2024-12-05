console.log("loading js")

document.addEventListener("DOMContentLoaded", () => {
    const searchButton = document.getElementById("search-button");
    const ingredientInput = document.getElementById("ingredient");
    const recipesList = document.getElementById("recipes-list");

    // HIDE KEY!!!
    const apiKey = "41508a215dec45bd93fe8f98c36450c0" 

    searchButton.addEventListener("click", () => {
      const ingredient = ingredientInput.value.trim();
      
      if (ingredient) {
        fetchRecipes(ingredient, apiKey);
      } else {
        alert("Please enter an ingredient.");
      }
    });

    function fetchRecipes(ingredient, apiKey) {
      const url = `https://api.spoonacular.com/recipes/findByIngredients?ingredients=${ingredient}&number=5&apiKey=${apiKey}`;
      
      // Show loading message
      recipesList.innerHTML = "Loading recipes...";

      fetch(url)
        .then(response => response.json())
        .then(data => displayRecipes(data))
        .catch(error => {
          console.error("Error fetching recipes:", error);
          recipesList.innerHTML = "There was an error fetching recipes.";
        });
    }

    function displayRecipes(recipes) {
      if (recipes.length > 0) {
        const recipeHtml = recipes.map(recipe => {
          return `
            <div class="recipe">
              <h3>${recipe.title}</h3>
              <p>Used Ingredients: ${recipe.usedIngredientCount}</p>
              <p>Missed Ingredients: ${recipe.missedIngredientCount}</p>
              <a href="${recipe.sourceUrl}" target="_blank">View Recipe</a>
            </div>
          `;
        }).join("");
        recipesList.innerHTML = recipeHtml;
      } else {
        recipesList.innerHTML = "No recipes found for this ingredient.";
      }
    }
});

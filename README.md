# Recipeasy

Recipeasy is a full-stack web application that helps users organize, find, and save recipes based on their available ingredients. It allows users to explore recipes from an API, save them to their personal collection, and manage ingredients effectively.

---

## Features

### 1. User Authentication
- Secure sign-up, log-in, and log-out functionality.
- Access recipes and shopping lists only when authenticated.

### 2. Recipe Management
- **Add Recipes**:
  - Add recipes manually through a form.
  - Fetch and save recipes dynamically from the Spoonacular API.
- **View Recipes**:
  - View a personalized list of saved recipes.
  - See recipe details, including title, description, ingredients, and instructions.
- **Delete Recipes**:
  - Remove recipes from the saved list.

### 3. Ingredient Management
- **Add Ingredients**:
  - Add ingredients to your recipes dynamically through the form or API.
  - Store details such as ingredient name, quantity, and unit of measurement.
- **View Ingredients**:
  - Manage all your ingredients in one place.
  - Ingredients are shared across recipes to avoid duplication.

### 4. Shopping List
- **Create a Shopping List**:
  - Add ingredients from your recipes or manually to a shopping list.
- **Delete Items**:
  - Remove ingredients from the shopping list without affecting recipes.
- **View Shopping List**:
  - Access a personalized shopping list associated with your account.

### 5. API Integration
- Integrates with the **Spoonacular API** to:
  - Search for recipes based on specific ingredients.
  - Fetch detailed recipe information, including instructions and images.

### 6. Dynamic User Interface
- **Search Recipes**:
  - Dynamically search for recipes by entering ingredients in a search bar.
- **Dynamic Ingredient Management**:
  - Add or remove ingredients dynamically using JavaScript.
- **Loading Indicators**:
  - Display a "Loading..." message while API data is being fetched.

---

## Technologies Used

- **Frontend**:
  - HTML, CSS, JavaScript
  - Dynamic UI interactions with jQuery
  - Responsive design using custom CSS

- **Backend**:
  - Ruby on Rails (MVC Framework)
  - PostgreSQL database for relational data management

- **Third-Party Integrations**:
  - [Spoonacular API](https://spoonacular.com/food-api) for fetching recipes and ingredients

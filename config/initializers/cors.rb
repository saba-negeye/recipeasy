# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins "https://recipeasyapp-db42d1ef1b41.herokuapp.com/"  # Replace with your actual frontend domain

      resource "*",
        headers: :any,
        methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
        credentials: true  # Allows cookies and HTTP authentication
    end
  end

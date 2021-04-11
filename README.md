# Setup Instructions

Things you may want to cover:

* Ruby version
  2.6.6

* Rails version
  6.0

* System dependencies
  None

* Configuration
  Make sure to set postgres password in database.yml

* Database creation
  rails db:create

* Database initialization
  rails db:migrate

# How to run the test suite
  ```ruby
  rspec
  ```

* Test Case Coverage
  Over 95 percent for Controllers and Models  []

  ![image](https://user-images.githubusercontent.com/48410696/114301202-4326d380-9add-11eb-8c2e-4b85ebd365bc.png)



# Run App
  ```ruby
  rails server
  ```

# Routes
  ```ruby
  rake routes
  ```

  Following REST conventions

  ### Task
  - /api/v1/tasks
  - GET /       => :index
  - GET /:id    => :show
  - POST /      => :create
  - PATCH /:id  => :update
  - DELETE /:id => :destroy

  
  ### Tag
  - /api/v1/tags
  - GET /       => :index
  - GET /:id    => :show
  - POST /      => :create

# A Look at Gemfile
  - kaminari for pagination
  - simplecov for test case coverage
  - rspec-rails for Test Driven Development



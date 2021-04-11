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
  Over 90 percent for Controllers and Models  []

  ![myimage-alt-tag](https://raw.githubusercontent.com/thezainsaleem/concerts-manager/main/Screenshot%20from%202021-01-30%2022-12-54.png)


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



# Rails as an API

  ## Generating a Rails project as an API
  * To generate a Rails API:
      `rails new backend --api`
  * If we want intend to deploy our app somewhere (like heroku), we need to set it up with a PostgresQL database by adding one more flag:
      `rails new backend --api --database=postgresql`
  
  ## Configuring CORS
  * CORS allows our app to only accept requests from specific URLs
  * Any API only Rails app is generated with this file.
  * Make sure to comment `gem 'cors'` back in in your Gemfile.
  * We specify the configuration in `config/initializers/cors.rb`
  * Comment the following lines back in:
    ```
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins 'example.com'

          resource '*',
            headers: :any,
            methods: [:get, :post, :put, :patch, :delete, :options, :head]
        end
      end
    ```

* Change this line `origins 'example.com'` to this:
`origins '*'`
* `origins` allows us to specify where we will accept requests from. When we use `*`, we're allowing requests from ANYWHERE. 
**Only use the asterisk when working locally. We want to set specific origins when our app is deployed.**

## Getting Started
  * Once you have completed the initial setup, create models and tables. You can use the resource generator to do so: `rails g resource Model attributes`
  * A lot of the setup is going to happen in the controllers.

## Render
  * Previously we have used `render` to either implicity or explicity render views in our actions
  * However, we can use `render` to also produce different formats of our data
  * For a Rails backend/JavaScript frontend, we will use `render json:` 

  **Example**
    ```
    def index
      authors = Author.all
      render json: authors
    end
    ```

## Returning Specific Pieces of Data
  * In certain cases, we might not want to include all the attributes of an object in the JSON being produced. We can actually specify which attributes to return as JSON. This is done in 2 ways:

  - Explicitly returning specific attributes in the controller:
    ``` 
    render json: authors, 
      only: [:id, :first_name, :last_name]
    ```
    or:
      ```
      render json: authors, 
      except: [:created_at, :updated_at]
      ```
  - We might also want to include related objects in our response:
    ```
    render json: authors, 
      only: [:id, :first_name, :last_name], 
      include: [:books]
    ```
  - We can specify the attributes we want returned for the associated object: 
    ```
    render json: authors, 
      only: [:id, :first_name, :last_name], 
      include: { books: { only: [:title, :genre, :pages, :publisher]} }
    ```

## Serializers
  * Serializers allow us to encapsulate our modifications to our data structures and distribute it to our controller actions much more organized
  * There are a few serializers to use: [ActiveModel Serializer](https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/getting_started.md) and [fast JSON:API](https://github.com/Netflix/fast_jsonapi)

  **Note: Fast JSON API is no longer maintained.**

### Active Model Serializer
* Add to Gemfile: `gem 'active_model_serializers'`
* Run `bundle`
* Run `rails g serializer serialized_model`
* Navigate to folder/files generated by the last command
* Use `attributes` method to determine which attributes are to be returned in the response:
  ```
    class AuthorSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name
    end
  ```
- Controller should look like:
  ```
    def index
      authors = Author.all 
      render json: authors
    end 
  ```

### Fast JSON API
* Add to Gemfile: `gem 'fast_jsonapi'`
* Run `bundle`
* Run `rails g serializer Model attribute`
* Navigate to folders/files generated by the last command
- Serializer class should look like:
  ```
    class AuthorSerializer
      include FastJsonapi::ObjectSerializer
      attributes :id, :first_name, :last_name
      has_many :books # this will return related object, in order to so, this object must have a serializer initialized as well
    end
  ```
- Controller will now look like:
  ```
  def index
    authors = Author.all 
    render json: AuthorSerializer.new(authors)
  end 
  ```

- To include associated objects as well:

  ```
  def index
    authors = Author.all 
    render json: AuthorSerializer.new(authors, {include: [:books]})
  end 
  ```
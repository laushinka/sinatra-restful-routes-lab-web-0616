class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  # get '/' do
  #   erb :index
  # end
# Creates new recipe
  get '/recipes/new' do
    erb :new
  end

# Renders a form to create a new recipe.
# Should create and save this new recipe to the database.
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

# Renders the edit form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

# Renders a form to edit a single recipe.
# Updates the entry in the database with the changes,
# and then redirect to the recipe show page.
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(params)
    redirect to "/recipes/#{@recipe.id}"
  end

# Displays all the recipes in the database.
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # Form that allows a user to delete a recipe.
  # This form should submit to a controller action
  # that deletes the entry from the database
  # and redirects to the index page.
  delete '/recipes/:id/delete' do
    # Find the recipe according to the passed in ID parameter
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end
end

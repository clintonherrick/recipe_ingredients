require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end


get('/ingredients') do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

post('/ingredients') do
  name = params.fetch("ingredient")
  Ingredient.create({name: name})
  redirect("/ingredients")
end

post('/recipes') do
  name = params.fetch("recipes")
  Recipe.create({:name => name})
  redirect('/recipes')
end

get('/recipe/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  erb(:recipe)
end

post('/recipe/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  ingredient = params.fetch('ingredient')
  @recipe.ingredients.create({:name => ingredient})
  redirect("/recipe/#{@recipe.id()}")
end

get('/ingredient/:id') do
  @ingredient = Ingredient.find(params.fetch("id").to_i())
  erb(:ingredient)
end


post('/ingredient/:id') do
  @ingredient = Ingredient.find(params.fetch("id").to_i())
  recipe = params.fetch('recipe')
  @ingredient.recipes.create({:name => recipe})
  redirect("/ingredient/#{@ingredient.id()}")
end

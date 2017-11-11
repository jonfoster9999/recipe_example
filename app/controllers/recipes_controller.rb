class RecipesController < ApplicationController
    def new 
        @recipe = Recipe.new 
        @recipe.ingredients.build
        @recipe.ingredients.build
        @recipe.ingredients.build
    end

    def index 
        @recipes = Recipe.all
    end

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def create 
        @recipe = Recipe.create(recipe_params)
        redirect_to(@recipe)
    end

    def show 
        @recipe = Recipe.find(params[:id])
    end

    def update 
        @recipe = Recipe.find(params[:id])
        @recipe.update(recipe_params)
        redirect_to(@recipe)    
    end

    def destroy 
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        redirect_to("/recipes")
    end

    def recipe_params 
        params.require(:recipe).permit(:name, :description, :ingredients_attributes => {}, :ingredients => {})
    end


end
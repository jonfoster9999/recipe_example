class RecipesController < ApplicationController
    def new 
        @recipe = Recipe.new 
        5.times do 
            @recipe.ingredients.build
        end
    end

    def index 
        @recipes = Recipe.all
    end

    def edit
        @recipe = Recipe.find(params[:id])
        build_more_recipes @recipe
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

    private
    def build_more_recipes(recipe)
        difference = 5 - recipe.ingredients.length
        difference.times do 
            recipe.ingredients.build
        end
    end
end

module ApplicationHelper
    def find_quantity(recipe, ingredient)
        ri = RecipeIngredient.find_by(:recipe_id => recipe.id, :ingredient_id => ingredient.id)
        if ri
            ri.quantity 
        else
            ""
        end
    end

    def build_more_recipes(recipe)
        difference = 3 - recipe.ingredients.length
        difference.times do 
            recipe.ingredients.build
        end
        recipe
    end
end

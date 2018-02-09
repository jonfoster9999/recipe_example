module ApplicationHelper
    def find_quantity(recipe, ingredient)
        ri = RecipeIngredient.find_by(:recipe_id => recipe.id, :ingredient_id => ingredient.id)
        if ri
            ri.quantity
        else
            ""
        end
    end
end

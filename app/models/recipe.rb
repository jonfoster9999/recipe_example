class Recipe < ApplicationRecord
    has_many :recipe_ingredients 
    has_many :ingredients, through: :recipe_ingredients

    def ingredients_attributes=(ingredients_attributes)
        ingredients_attributes.each do |key, value|
           
            ## if value["name"] is blank, don't do anything 
            ## on this iteration
            if !value["name"].blank?
                
                ## if no ingredient id (value["id"]) is present, we know we're creating and not editing
                ## our first check can't just be by name because if we're in edit mode, 
                ## the name might be different because we might have changed it
                ## so first we check if the id is present,
                ## if not we check if the ingredient was already created by another recipe
                ## if neither of those are true we make a brand new ingredient
                ingredient = Ingredient.find_by(:id => value["id"]) || 
                             Ingredient.find_by(:name => value["name"]) || 
                             Ingredient.new

                ## in any case it is safe to assign the params 'name' to this ingredient
                ingredient.name = value["name"]
                ingredient.save

                ## if the relationship between the recipe already exists,
                ## we don't want to make a new join table, we want to edit
                ## the existing one
                join = RecipeIngredient.find_or_create_by(
                    :recipe_id => self.id, 
                    :ingredient_id => ingredient.id
                    )
                join.quantity = value["quantity"]
                join.recipe = self         
                join.save
            end
        end
    end

    def ingredients=(ingredient_ids)
        ## just rename this because 'ingredient_ids' doesn't describe what this is
        ingredient_objects = ingredient_ids
        ingredient_objects.each do |i, ingredient_object|
            if ingredient_object["id"] != ""
               ingredient = Ingredient.find(ingredient_object["id"])
               if !self.ingredients.include?(ingredient)
                self.recipe_ingredients.build(
                    :quantity => ingredient_object["quantity"],
                    :ingredient_id => ingredient_object["id"],
                    :recipe_id => self.id
                    )
               end
            end
        end
    end
end


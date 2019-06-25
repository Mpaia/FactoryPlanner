-- This is essentially just a wrapper-'class' for a recipe prototype to add some data to it
Recipe = {}

function Recipe.init(recipe_id)
    local proto = global.all_recipes.recipes[recipe_id]
    return {
        proto = proto,
        energy = proto.energy,
        sprite = ui_util.generate_recipe_sprite(proto),
        valid = true,
        class = "Recipe"
    }
end


-- Update the validity of this recipe
function Recipe.update_validity(self)
    local new_recipe_id = new.all_recipes.map[self.proto.name]
    if new_recipe_id ~= nil then
        self.proto = new.all_recipes.recipes[new_recipe_id]
        self.valid = true
    else
        self.proto = self.proto.name
        self.valid = false
    end

    return self.valid
end

-- Tries to repair this recipe, deletes it otherwise (by returning false)
-- If this is called, the recipe is invalid and has a string saved to proto
function Recipe.attempt_repair(self, player)
    local current_recipe_id = global.all_recipes.map[self.proto]
    if current_recipe_id ~= nil then
        self.proto = global.all_recipes.recipes[current_recipe_id]
        self.sprite = ui_util.generate_recipe_sprite(self.proto)
        self.valid = true
    end

    return self.valid
end
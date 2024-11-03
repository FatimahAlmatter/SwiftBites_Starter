import Foundation
import SwiftData

@Model
final class CategoryModel: Identifiable, Hashable {
    let id = UUID()
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .nullify) var recipes: [Recipe]
    
    init(name: String = "", recipes: [Recipe] = []) {
        self.name = name
        self.recipes = recipes
    }
    
    /// Nullifies the `category` field of associated recipes before deleting this category.
    func nullifyCategoryInRecipes(context: ModelContext) {
        for recipe in recipes {
            recipe.category = nil
        }
        try? context.save()
    }
}

@Model
final class Ingredient: Identifiable, Hashable {
    let id = UUID()
    @Attribute(.unique) var name: String
    
    init(name: String = "") {
        self.name = name
    }
}

@Model
final class RecipeIngredient: Identifiable, Hashable {
    let id = UUID()
    @Relationship var ingredient: Ingredient
    var quantity: String
    
    init(ingredient: Ingredient, quantity: String = "") {
        self.ingredient = ingredient
        self.quantity = quantity
    }
}

@Model
final class Recipe: Identifiable, Hashable {
    let id = UUID()
    @Attribute(.unique) var name: String
    var summary: String
    @Relationship(deleteRule: .cascade) var category: CategoryModel?
    var serving: Int
    var time: Int
    @Relationship(deleteRule: .nullify) var ingredients: [RecipeIngredient]
    var instructions: String
    var imageData: Data?
    
    init(
        name: String = "",
        summary: String = "",
        category: CategoryModel? = nil,
        serving: Int = 1,
        time: Int = 5,
        ingredients: [RecipeIngredient] = [],
        instructions: String = "",
        imageData: Data? = nil
    ) {
        self.name = name
        self.summary = summary
        self.category = category
        self.serving = serving
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
        
        if let category = category {
            category.recipes.append(self)
        }
        
    }
}

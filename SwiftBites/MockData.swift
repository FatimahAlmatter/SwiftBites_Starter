//
//  MockData.swift
//  SwiftBites
//
//  Created by Fatimah Almatter on 02/11/2024.
//

import SwiftData
import Foundation
import UIKit

class MockData {
    func load(context: ModelContext) {
        let ingredientNames = [
            "Pizza Dough", "Tomato Sauce", "Mozzarella Cheese", "Fresh Basil Leaves",
            "Extra Virgin Olive Oil", "Salt", "Chickpeas", "Tahini",
            "Lemon Juice", "Garlic", "Cumin", "Water",
            "Paprika", "Parsley", "Spaghetti", "Eggs",
            "Parmesan Cheese", "Pancetta", "Black Pepper", "Dried Chickpeas",
            "Onions", "Cilantro", "Coriander", "Baking Powder",
            "Chicken Thighs", "Yogurt", "Cardamom", "Cinnamon",
            "Turmeric"
        ]
        
        var ingredients: [Ingredient] = []
        
        for name in ingredientNames {
            let ingredient = Ingredient(name: name)
            context.insert(ingredient)
            ingredients.append(ingredient)
        }
        
        let italian = CategoryModel(name: "Italian")
        let middleEastern = CategoryModel(name: "Middle Eastern")
        
        context.insert(italian)
        context.insert(middleEastern)
        
        let margherita = Recipe(
            name: "Classic Margherita Pizza",
            summary: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil.",
            category: italian,
            serving: 4,
            time: 50,
            ingredients: [
                RecipeIngredient(ingredient: ingredients[0], quantity: "1 ball"),
                RecipeIngredient(ingredient: ingredients[1], quantity: "1/2 cup"),
                RecipeIngredient(ingredient: ingredients[2], quantity: "1 cup, shredded"),
                RecipeIngredient(ingredient: ingredients[3], quantity: "A handful"),
                RecipeIngredient(ingredient: ingredients[4], quantity: "2 tablespoons"),
                RecipeIngredient(ingredient: ingredients[5], quantity: "Pinch")
            ],
            instructions: "Preheat oven, roll out dough, apply sauce, add cheese and basil, bake for 20 minutes.",
            imageData: UIImage(named: "margherita")?.pngData()
        )
        
        let spaghettiCarbonara = Recipe(
            name: "Spaghetti Carbonara",
            summary: "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
            category: italian,
            serving: 4,
            time: 30,
            ingredients: [
                RecipeIngredient(ingredient: ingredients[14], quantity: "400g"),
                RecipeIngredient(ingredient: ingredients[15], quantity: "4"),
                RecipeIngredient(ingredient: ingredients[16], quantity: "1 cup, grated"),
                RecipeIngredient(ingredient: ingredients[17], quantity: "200g, diced"),
                RecipeIngredient(ingredient: ingredients[18], quantity: "To taste")
            ],
            instructions: "Cook spaghetti. Fry pancetta until crisp. Whisk eggs and Parmesan, add to pasta with pancetta, and season with black pepper.",
            imageData: UIImage(named: "spaghettiCarbonara")?.pngData()
        )
        
        let hummus = Recipe(
            name: "Classic Hummus",
            summary: "A creamy and flavorful Middle Eastern dip made from chickpeas, tahini, and spices.",
            category: middleEastern,
            serving: 6,
            time: 10,
            ingredients: [
                RecipeIngredient(ingredient: ingredients[6], quantity: "1 can (15 oz)"),
                RecipeIngredient(ingredient: ingredients[7], quantity: "1/4 cup"),
                RecipeIngredient(ingredient: ingredients[8], quantity: "3 tablespoons"),
                RecipeIngredient(ingredient: ingredients[9], quantity: "1 clove, minced"),
                RecipeIngredient(ingredient: ingredients[4], quantity: "2 tablespoons"),
                RecipeIngredient(ingredient: ingredients[10], quantity: "1/2 teaspoon"),
                RecipeIngredient(ingredient: ingredients[5], quantity: "To taste"),
                RecipeIngredient(ingredient: ingredients[11], quantity: "2-3 tablespoons"),
                RecipeIngredient(ingredient: ingredients[12], quantity: "For garnish"),
                RecipeIngredient(ingredient: ingredients[13], quantity: "For garnish")
            ],
            instructions: "Blend chickpeas, tahini, lemon juice, garlic, and spices. Adjust consistency with water. Garnish with olive oil, paprika, and parsley.",
            imageData: UIImage(named: "hummus")?.pngData()
        )
        
        let falafel = Recipe(
            name: "Classic Falafel",
            summary: "A traditional Middle Eastern dish of spiced, fried chickpea balls, often served in pita bread.",
            category: middleEastern,
            serving: 4,
            time: 60,
            ingredients: [
                RecipeIngredient(ingredient: ingredients[19], quantity: "1 cup"),
                RecipeIngredient(ingredient: ingredients[20], quantity: "1 medium, chopped"),
                RecipeIngredient(ingredient: ingredients[9], quantity: "3 cloves, minced"),
                RecipeIngredient(ingredient: ingredients[21], quantity: "1/2 cup, chopped"),
                RecipeIngredient(ingredient: ingredients[13], quantity: "1/2 cup, chopped"),
                RecipeIngredient(ingredient: ingredients[10], quantity: "1 tsp"),
                RecipeIngredient(ingredient: ingredients[11], quantity: "1 tsp"),
                RecipeIngredient(ingredient: ingredients[5], quantity: "1 tsp"),
                RecipeIngredient(ingredient: ingredients[22], quantity: "1/2 tsp")
            ],
            instructions: "Soak chickpeas overnight. Blend with onions, garlic, herbs, and spices. Form into balls, add baking powder, and fry until golden.",
            imageData: UIImage(named: "falafel")?.pngData()
        )
        
        let shawarma = Recipe(
            name: "Chicken Shawarma",
            summary: "A popular Middle Eastern dish featuring marinated chicken, slow-roasted to perfection.",
            category: middleEastern,
            serving: 4,
            time: 120,
            ingredients: [
                RecipeIngredient(ingredient: ingredients[23], quantity: "1 kg, boneless"),
                RecipeIngredient(ingredient: ingredients[24], quantity: "1 cup"),
                RecipeIngredient(ingredient: ingredients[9], quantity: "3 cloves, minced"),
                RecipeIngredient(ingredient: ingredients[8], quantity: "3 tablespoons"),
                RecipeIngredient(ingredient: ingredients[10], quantity: "1 tsp"),
                RecipeIngredient(ingredient: ingredients[11], quantity: "1 tsp"),
                RecipeIngredient(ingredient: ingredients[25], quantity: "1/2 tsp"),
                RecipeIngredient(ingredient: ingredients[26], quantity: "1/2 tsp"),
                RecipeIngredient(ingredient: ingredients[27], quantity: "1/2 tsp"),
                RecipeIngredient(ingredient: ingredients[5], quantity: "To taste"),
                RecipeIngredient(ingredient: ingredients[18], quantity: "To taste"),
                RecipeIngredient(ingredient: ingredients[4], quantity: "2 tablespoons")
            ],
            instructions: "Marinate chicken with yogurt, spices, garlic, lemon juice, and olive oil. Roast until cooked. Serve with pita and sauces.",
            imageData: UIImage(named: "chickenShawarma")?.pngData()
        )
        
        italian.recipes = [margherita, spaghettiCarbonara]
        middleEastern.recipes = [hummus, falafel, shawarma]
        
        [margherita, spaghettiCarbonara, hummus, falafel, shawarma].forEach {
            context.insert($0)
        }
    }
}

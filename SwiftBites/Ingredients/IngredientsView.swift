import SwiftUI
import SwiftData

struct IngredientsView: View {
    typealias Selection = (Ingredient) -> Void
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let selection: Selection?
    @Query var ingredients: [Ingredient]
    @State private var query = ""
    
    init(selection: Selection? = nil) {
        self.selection = selection
        
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Ingredients")
                .toolbar {
                    if !ingredients.isEmpty {
                        NavigationLink(value: IngredientForm.Mode.add) {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
                .navigationDestination(for: IngredientForm.Mode.self) { mode in
                    IngredientForm(mode: mode)
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if ingredients.isEmpty {
            empty
        } else {
            list(for: ingredients.filter {
                if query.isEmpty {
                    return true
                } else {
                    return $0.name.localizedStandardContains(query)
                }
            })
        }
    }
    
    private var empty: some View {
        ContentUnavailableView(
            label: {
                Label("No Ingredients", systemImage: "list.clipboard")
            },
            description: {
                Text("Ingredients you add will appear here.")
            },
            actions: {
                NavigationLink("Add Ingredient", value: IngredientForm.Mode.add)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
            }
        )
    }
    
    private var noResults: some View {
        ContentUnavailableView(
            label: {
                Text("Couldn't find \"\(query)\"")
            }
        )
        .listRowSeparator(.hidden)
    }
    
    private func list(for ingredients: [Ingredient]) -> some View {
        List {
            if ingredients.isEmpty {
                noResults
            } else {
                ForEach(ingredients) { ingredient in
                    row(for: ingredient)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                delete(ingredient: ingredient)
                            }
                        }
                }
            }
        }
        .searchable(text: $query)
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private func row(for ingredient: Ingredient) -> some View {
        if let selection {
            Button(
                action: {
                    selection(ingredient)
                    dismiss()
                },
                label: {
                    title(for: ingredient)
                }
            )
        } else {
            NavigationLink(value: IngredientForm.Mode.edit(ingredient)) {
                title(for: ingredient)
            }
        }
    }
    
    private func title(for ingredient: Ingredient) -> some View {
        Text(ingredient.name)
            .font(.title3)
    }
    
    private func delete(ingredient: Ingredient) {
        context.delete(ingredient)
        try? context.save()
    }
}

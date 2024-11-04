import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Query private var categories: [CategoryModel]
    @State private var query = ""
    @Environment(\.modelContext) private var context
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Categories")
                .toolbar {
                    if !filteredCategories.isEmpty {
                        NavigationLink(value: CategoryForm.Mode.add) {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
                .navigationDestination(for: CategoryForm.Mode.self) { mode in
                    CategoryForm(mode: mode)
                }
                .navigationDestination(for: RecipeForm.Mode.self) { mode in
                    RecipeForm(mode: mode)
                }
        }
        .searchable(text: $query)
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var content: some View {
        if categories.isEmpty {
            empty
        } else {
            list(for: filteredCategories)
        }
    }
    
    private var filteredCategories: [CategoryModel] {
        let predicate = #Predicate { (category: CategoryModel) in
            category.name.localizedStandardContains(query)
        }
        
        let descriptor = FetchDescriptor<CategoryModel>(
            predicate: query.isEmpty ? nil : predicate
        )
        
        do {
            let filteredCategories: [CategoryModel] = try context.fetch(descriptor)
            return filteredCategories
        } catch {
            print("Failed to fetch categories: \(error)")
            return []
        }
    }
    
    private var empty: some View {
        ContentUnavailableView(
            label: {
                Label("No Categories", systemImage: "list.clipboard")
            },
            description: {
                Text("Categories you add will appear here.")
            },
            actions: {
                NavigationLink("Add Category", value: CategoryForm.Mode.add)
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
    }
    
    private func list(for categories: [CategoryModel]) -> some View {
        ScrollView(.vertical) {
            if categories.isEmpty {
                noResults
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(categories, content: CategorySection.init)
                }
            }
        }
    }
}

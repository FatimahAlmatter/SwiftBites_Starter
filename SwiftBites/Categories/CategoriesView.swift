import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Query private var categories: [CategoryModel]
    @State private var query = ""
    
    private var filteredCategories: [CategoryModel] {
        categories.filter { category in
            query.isEmpty || category.name.localizedStandardContains(query)
        }
    }
    
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
        if filteredCategories.isEmpty {
            empty
        } else {
            list(for: filteredCategories)
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

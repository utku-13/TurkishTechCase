//
//  FavouriteView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct FavouriteView: View {
    @Environment(\.managedObjectContext) private var context

    // Core Data'dan sadece favouriteları çekiyoruz
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "isFavourite == YES")
    ) private var favourites: FetchedResults<Favourite>

    @StateObject var viewModel = ListViewViewModel()

    // Core Data’daki favouritelerin id seti
    private var favouriteIds: Set<Int64> {
        Set(favourites.map { $0.id })
    }

    var body: some View {
        NavigationStack {
            VStack {

                // API’den gelen ürünleri filtreliyoruz → sadece favouritelerde olanlar kalıyor
                let filteredItems = viewModel.items.filter {
                    favouriteIds.contains(Int64($0.id))
                }

                if filteredItems.isEmpty {
                    Text("No favourites yet!! Go add some")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List(filteredItems, id: \.id) { item in
                        ListItemView(item: item)
                    }
                }

            }
            .navigationTitle("Favourites")
            .onAppear {
                viewModel.fetchItems()
            }
        }
    }
}

#Preview {
    let controller = DataController(inMemory: true)
    return FavouriteView()
        .environment(\.managedObjectContext, controller.container.viewContext)
}

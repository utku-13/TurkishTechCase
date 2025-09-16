//
//  FavouriteView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct FavouriteView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "isFavourite == YES")
    ) private var favourites: FetchedResults<Favourite>

    @StateObject var viewModel = ListViewViewModel()

    private var favouriteIds: Set<Int64> {
        Set(favourites.map { $0.id })
    } // Favorilerin idlerini topladık aşşağıda contain ile karşılaştırıcaz.

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("❌ Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    // Filtered the favourite product ids and compare then paste
                    List(
                        viewModel.items.filter {
                            favouriteIds.contains(Int64($0.id))
                        },
                        id: \.id
                    ) { item in
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
    FavouriteView()
}

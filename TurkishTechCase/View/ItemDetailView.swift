//
//  ItemDetailView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI
import Kingfisher

struct ItemDetailView: View {
    
    @StateObject var modelView = ItemDetailViewViewModel()
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var favourites: FetchedResults<Favourite>
    
    private func toggleFavorite() {
            if let fav = favourites.first {
                fav.isFavourite.toggle()
            } else {
                let fav = Favourite(context: context)
                fav.id = Int64(item.id)
                fav.isFavourite = true
            }
            try? context.save()
        }
    
    private var isFavorite: Bool {
            favourites.first?.isFavourite ?? false
        }
    
    let item: ListItem // initialize ederken ilk iş detayı açılacak obje ile dolacak.
    
    init(item: ListItem) {
            self.item = item
            _favourites = FetchRequest(
                sortDescriptors: [],
                predicate: NSPredicate(format: "id == %lld", item.id) // item.id -> Int
            )
        }

    var body: some View {
        // yazılar taşarsa diye bir önlem aldık Kaydırılabilir artık.
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 16)

                DetailPage(item: item)
            }
            .padding()
        }
    }

    // Burada Yine modüler bir yaklaşım olması amacıyla ayırdık.
    @ViewBuilder
    func DetailPage(item: ListItem) -> some View {
        VStack(alignment: .leading, spacing: 16) {

            KFImage(URL(string: item.image))
                .placeholder { ProgressView() }
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(16)
                .shadow(radius: 8)

            HStack {
                Text(item.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Spacer()

                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                        .font(.system(size: 28))
                }
            }

            Text(String(format: "$%.2f", item.price))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.green)

            Text(item.description)
            .font(.body)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.leading)
            .lineSpacing(4)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ItemDetailView(
        item: .init(
            id: 1,
            title: "Test",
            image: "placeholder",
            description:
                "This is a very very long explanation of the product. It describes the features, quality, and benefits in a nice and readable format.",
            price: 10.0,
        )
    )
}

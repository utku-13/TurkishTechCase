//
//  ItemDetailView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import Kingfisher
import SwiftUI

struct ItemDetailView: View {

    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: ItemDetailViewViewModel

    let item: ListItem

    init(item: ListItem, dataController: DataController) {
        self.item = item
        _viewModel = StateObject(
            wrappedValue: ItemDetailViewViewModel(
                item: item,
                dataController: dataController
            )
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
        }.task {
            await viewModel.load()
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

                Button {
                    Task {
                        await viewModel.toggleFavourite()
                    }
                } label: {
                    Image(
                        systemName: viewModel.isFavourite ? "star.fill" : "star"
                    )
                    .foregroundColor(viewModel.isFavourite ? .yellow : .gray)
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
    let controller = DataController(inMemory: true)
    return ItemDetailView(
        item: .init(
            id: 1,
            title: "Test",
            image: "https://via.placeholder.com/300",
            description: "This is a test product description",
            price: 10.0
        ),
        dataController: controller
    )
    .environment(\.managedObjectContext, controller.container.viewContext)
}

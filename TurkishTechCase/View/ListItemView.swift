//
//  ContentView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct ListItemView: View {

    let item: ListItem

    var body: some View {
        NavigationLink(destination: ItemDetailView()) {
            ProductCard(item:item)

        }
    }

    // Kodun modülerliğini korumak, daha okunaklı hale getirmek için ViewBuilder kullandık.
    @ViewBuilder
    func ProductCard(item:ListItem) -> some View {
        HStack {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(12)

                    Text(item.title)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(String(format: "$%.2f", item.price)) // Sadece son 2 ondalik
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text(item.description)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(6)  // sonra karar verilcek ortalama text uzunluklarına göre
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            )
            .padding(.horizontal)
        }
    }

}

#Preview {
    NavigationStack {
        ListItemView(
            item: .init(
                id: 1,
                title: "Test",
                image: "placeholder",
                description: "This is a very very long explanation of the product. It describes the features, quality, and benefits in a nice and readable format.",
                price: 10.0,
            )
        )
    }
}

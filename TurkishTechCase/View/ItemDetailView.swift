//
//  ItemDetailView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct ItemDetailView: View {

    @State private var isFavorite = false

    var body: some View {
        // yazılar taşarsa diye bir önlem aldık Kaydırılabilir artık.
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 16)

                DetailPage()
            }
            .padding()
        }
    }

    // Burada Yine modüler bir yaklaşım olması amacıyla ayırdık.
    @ViewBuilder
    func DetailPage() -> some View {
        VStack(alignment: .leading, spacing: 16) {

            Image("placeholder")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(16)
                .shadow(radius: 8)

            HStack {
                Text("Item Headline")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Spacer()

                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                        .font(.system(size: 28))
                }
            }

            Text("$199.99")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.green)

            Text(
                "This is a very very long explanation of the product. It describes the features, quality, and benefits in a nice and readable format."
            )
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
    ItemDetailView()
}

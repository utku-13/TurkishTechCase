//
//  ContentView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct ListItemView: View {
    var body: some View {
        NavigationLink(destination: ItemDetailView()) {
            ProductCard()

        }
    }

    // Kodun modülerliğini korumak, daha okunaklı hale getirmek için ViewBuilder kullandık.
    @ViewBuilder
    func ProductCard() -> some View {
        HStack {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(12)

                    Text("Product Name")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("$29.99")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text(
                    "This is a very very long explanation of the product. It describes the features, quality, and benefits in a nice and readable format."
                )
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
    NavigationView {
            ListItemView()
        }
}

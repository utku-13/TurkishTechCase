//
//  ListView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct ListView: View {

    @StateObject private var viewModel = ListViewViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("❌ Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.items, id: \.id) { item in
                        ListItemView(item: item)
                    }
                }
            }
            .navigationTitle("Products")
            .onAppear {
                viewModel.fetchItems()
            }
        }
    }
}

#Preview {
    ListView()
}

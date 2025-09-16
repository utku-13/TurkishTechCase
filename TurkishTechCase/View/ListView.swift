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
            VStack{
                Text("Dinamik Olarak Urunler gelicek")
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

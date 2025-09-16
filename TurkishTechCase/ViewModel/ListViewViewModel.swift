//
//  ListViewViewModel.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import Alamofire
import Foundation

class ListViewViewModel: ObservableObject {
    @Published var items: [ListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    func fetchItems() {
        let url = "https://fakestoreapi.com/products"
        
        
        
    }
}

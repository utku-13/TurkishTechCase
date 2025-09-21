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

    func fetchItems() async {
    do {
        let data = try await AF.request("https://fakestoreapi.com/products")
            .validate()
            .serializingData()
            .value
        
        // Move JSON decoding to background
        let products = await Task.detached {
            return [ListItem].fromJSON(data)
        }.value
        
        if let products = products {
            await MainActor.run {
                self.items = products
            }
        }
    } catch {
        print("API Error:", error)
    }
}
}

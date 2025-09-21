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
            
            if let products = [ListItem].fromJSON(data) { // decode içine yazdığımız extensionu kullandık burada.
                await MainActor.run {
                    self.items = products
                }
            }
        } catch {
            print("API Error:", error)
        }
    }
}

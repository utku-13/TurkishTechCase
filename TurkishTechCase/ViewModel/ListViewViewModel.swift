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

        AF.request("https://fakestoreapi.com/products")
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let products = [ListItem].fromJSON(data) { // decode içine yazdığımız extensionu kullandık burada.
                        self.items = products
                    }
                case .failure(let error):
                    print("API Error:", error)
                }
            }

    }
}

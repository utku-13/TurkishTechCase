//
//  ListItem.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import Foundation

struct ListItem: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let description: String
    let price: Double
    // var isFavorite: Bool

    //structun degismeme ozelliginden dolayi mutating keywordu
//    mutating func setFav(_ state: Bool) {
//        isFavorite = state
//    }
}

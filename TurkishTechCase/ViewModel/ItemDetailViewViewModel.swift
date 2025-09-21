//
//  ItemDetailViewViewModel.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import Foundation
import CoreData

final class ItemDetailViewViewModel: ObservableObject {
    @Published private(set) var isFavourite: Bool = false

    private let itemID: Int64
    private let dataController: DataController

    init(item: ListItem, dataController: DataController) {
        self.itemID = Int64(item.id)
        self.dataController = dataController
    }

    func load() async {
        let favourite = await dataController.isFavourite(itemID: itemID)
        await MainActor.run {
            self.isFavourite = favourite
        }
    }

    func toggleFavourite() async {
        do {
            let newState = try await dataController.toggleFavourite(itemID: itemID)
            await MainActor.run {
                self.isFavourite = newState
            }
        } catch {
            print("Toggle failed:", error)
        }
    }
}

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

    func load(context: NSManagedObjectContext) {
        isFavourite = dataController.isFavourite(itemID: itemID, in: context)
    }

    func toggleFavourite(in context: NSManagedObjectContext) {
        do {
            isFavourite = try dataController.toggleFavourite(itemID: itemID, in: context)
        } catch {
            print("Toggle failed:", error)
        }
    }
}

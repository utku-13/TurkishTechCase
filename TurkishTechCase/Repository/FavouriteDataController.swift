//
//  FavouriteDataController.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Favourite") // 👈 xcdatamodeld dosya adı

        if inMemory {
            let desc = NSPersistentStoreDescription()
            desc.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [desc]
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Persistent store error: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // MARK: - Repository Methods

    func favourite(for itemID: Int64, in context: NSManagedObjectContext) throws -> Favourite? {
        let req: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        req.fetchLimit = 1
        req.predicate = NSPredicate(format: "id == %lld", itemID)
        return try context.fetch(req).first
    }

    func isFavourite(itemID: Int64, in context: NSManagedObjectContext) -> Bool {
        (try? favourite(for: itemID, in: context)?.isFavourite) ?? false
    }

    func addToFavourites(itemID: Int64, in context: NSManagedObjectContext) throws {
        if let existing = try favourite(for: itemID, in: context) {
            existing.isFavourite = true
        } else {
            let fav = Favourite(context: context)
            fav.id = itemID
            fav.isFavourite = true
        }
        try context.save()
    }

    func removeFromFavourites(itemID: Int64, in context: NSManagedObjectContext) throws {
        if let fav = try favourite(for: itemID, in: context) {
            context.delete(fav)
            try context.save()
        }
    }

    /// Toggle mantığı: favoriyse sil, değilse ekle.
    @discardableResult
    func toggleFavourite(itemID: Int64, in context: NSManagedObjectContext) throws -> Bool {
        if let fav = try favourite(for: itemID, in: context) {
            if fav.isFavourite {
                context.delete(fav)         // favoriden çıkar
                try context.save()
                return false
            } else {
                fav.isFavourite = true     // var ama false → tekrar fav yap
                try context.save()
                return true
            }
        } else {
            try addToFavourites(itemID: itemID, in: context) // hiç yoksa → ekle
            return true
        }
    }
}


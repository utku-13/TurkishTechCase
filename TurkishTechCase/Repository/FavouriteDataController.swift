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

    // Background context for async operations
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Favourite") // xcdatamodeld dosya adı

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
    
    private func favourite(for itemID: Int64, in context: NSManagedObjectContext) throws -> Favourite? {
        let req: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        req.fetchLimit = 1
        req.predicate = NSPredicate(format: "id == %lld", itemID)
        return try context.fetch(req).first
    }

    func isFavourite(itemID: Int64) async -> Bool {
        return await backgroundContext.perform {
            return (try? self.favourite(for: itemID, in: self.backgroundContext)?.isFavourite) ?? false
        }
    }

    private func addToFavourites(itemID: Int64, in context: NSManagedObjectContext) throws {
        if let existing = try favourite(for: itemID, in: context) {
            existing.isFavourite = true
        } else {
            let fav = Favourite(context: context)
            fav.id = itemID
            fav.isFavourite = true
        }
        try context.save()
    }

    /// Toggle mantığı: favoriyse sil, değilse ekle.
    @discardableResult
    func toggleFavourite(itemID: Int64) async throws -> Bool {
        return try await backgroundContext.perform {
            if let fav = try self.favourite(for: itemID, in: self.backgroundContext) {
                if fav.isFavourite {
                    self.backgroundContext.delete(fav)         // favoriden çıkar
                    try self.backgroundContext.save()
                    return false
                } else {
                    fav.isFavourite = true     // var ama false → tekrar fav yap
                    try self.backgroundContext.save()
                    return true
                }
            } else {
                try self.addToFavourites(itemID: itemID, in: self.backgroundContext) // hiç yoksa → ekle
                return true
            }
        }
    }
}


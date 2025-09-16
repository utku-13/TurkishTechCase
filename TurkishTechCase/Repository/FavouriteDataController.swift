//
//  FavouriteDataController.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Favourite")
    
    init(){
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                print(error) // hata dolarsa çıktısını ver.
            }
        }
    }
}

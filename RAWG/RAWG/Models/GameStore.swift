//
//  GameStore.swift
//  RAWG
//
//  Created by Emir Keleş on 23.07.2023.
//

import Foundation
import CoreData

class GameStore {

  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "GameDataModel")
    container.loadPersistentStores { (desc, error) in
      if let error = error {
        print("Error setting up Core Data (\(error)).")
      }
    }
    return container
  }()

  func saveContextForFavorites() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
        print("Saved")
      } catch {
        let error = error as NSError
        fatalError("Unknown error while saving context (\(error), (\(error.userInfo))")
      }
    }
  }
}

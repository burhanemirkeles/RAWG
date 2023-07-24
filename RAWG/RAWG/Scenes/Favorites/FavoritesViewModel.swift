//
//  FavoritesViewModel.swift
//  RAWG
//
//  Created by Emir Keleş on 23.07.2023.
//

import Foundation
import CoreData
import UIKit

class FavoritesViewModel {

  var games: [Game] {
    return getGamesData() ?? []
  }
  weak var delegate: GamesViewModelDelegate?

  func getGamesData() -> [Game]? {
    var games: [Game] = []
    let gameStore = GameStore()
    let context = gameStore.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<GameData> = GameData.fetchRequest()

    do {
      let fetchedEntities = try context.fetch(fetchRequest)
      games = fetchedEntities.map { entity in

        let genresArray: [Genre] = entity.gameGenres?
          .components(separatedBy: ", ")
          .map { name in
            return Genre(name: name)
          } ?? []

        return Game(id: entity.id.hashValue,
                    name: entity.gameName ?? "",
                    genres: genresArray,
                    gameImage: entity.gameImage,
                    metacritic: Int(entity.gameMetacriticScore))
      }
    } catch {
      print("Error while getting data: \(error)")
      self.delegate?.didFetchGamesData()
      return nil
    }
    return games
  }

}



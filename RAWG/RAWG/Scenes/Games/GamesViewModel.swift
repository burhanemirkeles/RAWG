//
//  GamesViewModel.swift
//  RAWG
//
//  Created by Emir Keleş on 22.07.2023.
//

import UIKit
import Alamofire
import CoreData

class GamesViewModel {

  weak var delegate: GamesViewModelDelegate?
  var games: [Game] = []
  var gameDetail: GameDetail?
  var nextPage: String?
  var minimumCharacterLimitForSearch = 3
  var gameStore = GameStore()
  var selectedGameId: Int?

  func fetchGames() {
      AlamofireService.shared.requestGetGames { result in
          switch result {
          case .success(let (games, nextPage)):
            self.games.append(contentsOf: games)
              self.nextPage = nextPage
              self.delegate?.didFetchGamesData()
          case .failure(let error):
              print("Some error occured while fetching games data \(error)")
          }
      }
  }

  func fetchMoreGames(nextPage:String?) {
    AlamofireService.shared.requestGetMoreGames(nextPage: nextPage) { result in
        switch result {
        case .success(let (games, nextPage)):
          self.games.append(contentsOf: games)
            self.nextPage = nextPage
            self.delegate?.didFetchMoreGames()
        case .failure(let error):
            print("Oyunlar alınırken hata oluştu: \(error)")
        }
    }
  }

    func searchGames(text: String) {
      AlamofireService.shared.requestGetGamesWithSearch(searchText: text) { result in
        switch result {
        case .success(let games):
          self.games.append(contentsOf: games)
          self.delegate?.searchGame()
        case .failure(let error):
          print("Error fetching games: \(error)")
        }
      }
    }
  func getDetailGames(gameID: Int) {
    AlamofireService.shared.requestGetGamesDetail(gameID: gameID) { result in
      switch result {
      case .success(let games):
        self.gameDetail = games
        self.delegate?.getGameDetail()
      case .failure(let error):
        print("Error fetching games: \(error)")
      }
    }
  }

  func checkIsGameFavorited(desiredGameId: Int) -> Bool {

    let desiredId = desiredGameId
    var isFavorited = false

    let managedContext = gameStore.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameData")

    let predicate = NSPredicate(format: "gameId == %d", Int(desiredId))

    fetchRequest.predicate = predicate

    do {
      let result = try managedContext.fetch(fetchRequest)

      if result.first is NSManagedObject {
        isFavorited = true
      } else {
        isFavorited = false
      }
    } catch let error as NSError {
      print("Hata: \(error), \(error.userInfo)")
    }
    return isFavorited
  }

  func unfavoriteGame(withId: Int) {
    let context = gameStore.persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameData")

    let predicate = NSPredicate(format: "gameId == %d", Int(withId))
    fetchRequest.predicate = predicate

    do {
      let result = try context.fetch(fetchRequest)
      if let matchedEntity = result.first as? NSManagedObject {
        // 3. Seçilen Varlığı Silme
        context.delete(matchedEntity)

        // 4. Değişiklikleri Kaydetme
        try context.save()
      } else {
        // Eşleşen varlık bulunamadı
      }
    } catch let error as NSError {
      // Hata yönetimi yapılabilir
      print("Hata: \(error), \(error.userInfo)")
    }
  }

}

// MARK: Delegate
protocol GamesViewModelDelegate: AnyObject {
  func didFetchGamesData()
  func searchGame()
  func didFetchMoreGames()
  func getGameDetail()
}

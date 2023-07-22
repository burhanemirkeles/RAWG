//
//  GamesViewModel.swift
//  RAWG
//
//  Created by Emir Keleş on 22.07.2023.
//

import UIKit
import Alamofire

class GamesViewModel {

  weak var delegate: GamesViewModelDelegate?
  var games: [Game] = []
  var gameDetail: GameDetail?
  var nextPage: String?
  var minimumCharacterLimitForSearch = 3

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

}

// MARK: Delegate
protocol GamesViewModelDelegate: AnyObject {
  func didFetchGamesData()
  func searchGame()
  func didFetchMoreGames()
  func getGameDetail()
}
